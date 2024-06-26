//feather ignore all

if ANIMATION_AUTOMATIC_MODE {
	global.__animation_array = [];

	global.__animation_timesource = time_source_create(time_source_game, 1, time_source_units_frames, 
		function() {
			for (var i = array_length(global.__animation_array) - 1; i >= 0; i--;) {
			    if weak_ref_alive(global.__animation_array[i]) {
					var _anim_struct = global.__animation_array[i].ref;
					if instance_exists(_anim_struct.creator) {
						_anim_struct.__animate();
					}
					else {
						array_delete(global.__animation_array, i, 1);
					}
				}
				else {
					array_delete(global.__animation_array, i, 1);	
				}
			}
		},
		[], -1
	)
	time_source_start(global.__animation_timesource);
}

function __animation(_sprite, _loop = true) constructor {
	static __animation_get_speed = function(_sprite = sprite_index) {
		//TY Tabularelf for this function! I converted it from a ternary to an if/else cuz I can't read ternaries to save my life
		var _sprite_speed;
		if sprite_get_speed_type(_sprite) == spritespeed_framespergameframe {
			_sprite_speed = sprite_get_speed(_sprite);
		}
		else {
			_sprite_speed = sprite_get_speed(_sprite)/game_get_speed(gamespeed_fps);
		}
		return _sprite_speed;
	}
	
	if instance_exists(other) {
		creator = other.id;	
	}
	else {
		show_error("GM Animate: tried to use animation_start in a non-instance scope. \nGM Animate currently only supports being run on instances, not structs or other scopes.", true);	
	}
	
	static __animation_variable_setup = function() {
		image_number = sprite_get_number(sprite_index);
		sprite_speed = __animation_get_speed(sprite_index);
	}
	
	sprite_index = _sprite;
	__animation_variable_setup();
	image_index = 0;
	image_speed = 1;
	image_xscale = 1;
	image_yscale = 1;
	image_angle = 0;
	image_blend = c_white;
	image_alpha = 1;
	loop = _loop;
	paused = false;
	effect_pause = false;
	
	finished = false;
	new_frame = -1;
	
	static __reset_offsets = function() {
		x_offset = 0;
		y_offset = 0;
		xscale_offset = 0;
		yscale_offset = 0;
		angle_offset = 0;
		alpha_offset = 0;
	}
	
	__reset_offsets();
	
	effects = [];
	queue = [];
	
	static __animate = function() {

		finished = false;
		new_frame = -1;
		if paused == true {
			return;
		}
		if image_speed != 0 and effect_pause == false {
			var _previous_frame = floor(image_index);
			image_index += sprite_speed * image_speed;
			if image_speed > 0 {
				if image_index >= image_number {
					finished = true;
					if loop == true {
						image_index = 0;
					}
					else {
						image_speed = 0;
						image_index = image_number - 1;
					}
				}
			}
			else {
				//Backwards animation
				if image_index <= 0 {
					finished = true;
					if loop == true {
						image_index = image_number;	
					}
					else {
						image_index = 0;
						image_speed = 0;	
					}
				}
			}
			var _current_frame = floor(image_index);
			if _current_frame > _previous_frame or finished == true {
				new_frame = _current_frame;
			}
		}
		
		__reset_offsets();
		for (var j = array_length(effects) - 1; j > -1; j--;) {
			effects[j].step();
		}
		if finished and array_length(queue) > 0 {
			var _queue_data = queue[0];
			array_delete(queue, 0, 1);
			sprite_index = _queue_data.sprite_index;
			image_index = 0;
			image_speed = 1;
			loop = _queue_data.loop;
			__animation_variable_setup();
		}
	}
	
	static __draw = function(_x = other.x, _y = other.y) {
		draw_sprite_ext(sprite_index, image_index, _x + x_offset, _y + y_offset, image_xscale + (xscale_offset * image_xscale), 
		image_yscale + (yscale_offset * image_yscale), 
		image_angle + angle_offset, image_blend, image_alpha - alpha_offset);
	}
	
	if ANIMATION_AUTOMATIC_MODE {
		var _ref = weak_ref_create(self);
		array_push(global.__animation_array, _ref);
	}
}

function __animation_track_error(_track) {
	if _track != all and (_track > array_length(animations) - 1 or animations[_track] == 0 or _track < 0) {
		show_error("GM Animate: tried to access a track that does not exist on object " + object_get_name(object_index) + ", track " + string(_track) + ". \nMake sure the track is created first with animation_start() before using other functions on it.", true); 
	}
}

function ___animation_array_error() {
	if !instance_exists(self) {
		show_error("GM Animate: tried to use an animation function in a non-instance scope. \nRunning animations in struct or global scope is currently not supported.", true);
	}
	if !variable_instance_exists(id, "animations") { 
		show_error("GM Animate: tried to use an animation function on an object that never called animation_start: " + object_get_name(object_index) + "\nCall animation_start() on the object before using other animation functions.", true);
	} 
}

