global._animation_array = [];

global._animation_timesource = time_source_create(time_source_game, 1, time_source_units_frames, 
	function() {
		for (var i = array_length(global._animation_array) - 1; i >= 0; i--;) {
		    if weak_ref_alive(global._animation_array[i]) {
				global._animation_array[i].ref.animate();
			}
			else {
				array_delete(global._animation_array, i, 1);	
			}
		}
	},
	[], -1
)
time_source_start(global._animation_timesource);

function _animation(_sprite, _loop = true) constructor {
	
	static __animation_variable_setup = function() {
		image_number = sprite_get_number(sprite_index);
		sprite_speed = image_get_speed(sprite_index);
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
	
	finished = false;
	new_frame = -1;
	
	x_offset = 0;
	y_offset = 0;
	xscale_offset = 0;
	yscale_offset = 0;
	angle_offset = 0;
	
	effects = [];
	queue = [];
	
	static reset_offsets = function() {
		x_offset = 0;
		y_offset = 0;
		xscale_offset = 0;
		yscale_offset = 0;
		angle_offset = 0;
	}
	
	animate = function() {
		finished = false;
		new_frame = -1;
		if paused == false and image_speed > 0 {		
			var previous_frame = floor(image_index);
			image_index += sprite_speed * image_speed;
			var current_frame = floor(image_index);
			if current_frame > previous_frame {
				new_frame = current_frame;
			}
			
			if image_index >= image_number {
				finished = true;
				if loop == true {
					image_index = 0;	
				}
				else {
					image_speed = 0;	
				}
			}
		}
		reset_offsets();
		for (var i = array_length(effects) - 1; i > -1; i--;) {
		    effects[i].step();
		}
		if finished and array_length(queue) > 0 {
			var queue_data = array_shift(queue);
			sprite_index = queue_data.sprite_index;
			loop = queue_data.loop;
			__animation_variable_setup();
		}
	}
	
	draw = function(_x = other.x, _y = other.y) {
		draw_sprite_ext(sprite_index, image_index, _x + x_offset, _y + y_offset, image_xscale + xscale_offset, image_yscale + yscale_offset, 
		image_angle + angle_offset, image_blend, image_alpha);
	}
	
	var ref = weak_ref_create(self);
	array_push(global._animation_array, ref);
}

function _animation_track_error(_track) {
	if _track > array_length(animations) - 1 or animations[_track] == 0 {
		show_debug_message("Warning! Tried to access a track that does not exist on " + object_get_name(object_index) + ", track number " + string(_track)); 
		return true;
	}
	return false;
}

function _animation_array_error() {
	if !variable_instance_exists(id, "animations") { 
		show_debug_message("Warning! Tried to use an animation function on an object that did not call animation_init: " + object_get_name(object_index));
		return true;
	} 
	return false;
}

