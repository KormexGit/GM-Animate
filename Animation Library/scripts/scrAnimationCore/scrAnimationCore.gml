global._animationArray = [];

global._animationTimesource = time_source_create(time_source_game, 1, time_source_units_frames, 
	function() {
		for (var i = array_length(global._animationArray) - 1; i >= 0; i--;) {
		    if weak_ref_alive(global._animationArray[i]) {
				global._animationArray[i].ref.animate();
			}
			else {
				array_delete(global._animationArray, i, 1);	
			}
		}
	},
	[], -1
)
time_source_start(global._animationTimesource);

function animation(_sprite, _loop = true, _image_speed = 1) constructor {
	sprite_index = _sprite;
	image_index = 0;
	image_speed = _image_speed;
	image_number = sprite_get_number(sprite_index);
	sprite_speed = image_get_speed(sprite_index);
	image_xscale = 1;
	image_yscale = 1;
	image_angle = 0;
	image_blend = c_white;
	image_alpha = 1;
	loop = _loop;
	
	animate = function() {
		if image_speed > 0 {
			image_index += sprite_speed * image_speed;	
			if image_index >= image_number {
				if loop == true {
					image_index = 0;	
				}
				else {
					image_speed = 0;	
				}
			}
		}
	}
	
	draw = function(_x = other.x, _y = other.y) {
		draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	
	var ref = weak_ref_create(self);
	array_push(global._animationArray, ref);
}

function animation_play(_sprite, _loop = true) {
	if !variable_instance_exists(id, "_animationsArray") {
		_animationsArray = [];	
	}
	_animationsArray[0] = new animation(_sprite, _loop);
}


function animation_play_ext(_sprite, _track, _loop = true) {
	if !variable_instance_exists(id, "_animationsArray") {
		_animationsArray = [];	
	}
	_animationsArray[_track] = new animation(_sprite, _loop);
}

function animation_draw(_x = x, _y = y) {
	if !variable_instance_exists(id, "_animationsArray") {
		show_debug_message("Warning! Tried to draw an animation when no animation was set for object " + object_get_name(object_index));
		return;	
	}
	_animationsArray[0].draw(_x, _y);
}

function animation_draw_all(_x = x, _y = y) {
	if !variable_instance_exists(id, "_animationsArray") {
		show_debug_message("Warning! Tried to draw an animation when no animation was set for object " + object_get_name(object_index));
		return;	
	}
	for (var i = 0, len = array_length(_animationsArray); i < len; ++i) {
		_animationsArray[i].draw(_x, _y);
	}
}

function animation_draw_ext(_x = x, _y = y, _track) {
	if !variable_instance_exists(id, "_animationsArray") {
		show_debug_message("Warning! Tried to draw an animation when no animation was set for object " + object_get_name(object_index));
		return;	
	}
	_animationsArray[_track].draw(_x, _y);
}

function animation_set_frame(_frame) {
	_animationsArray[0].image_index = _frame;	
}

function animation_set_frame_ext(_frame, _track) {
	_animationsArray[_track].image_index = _frame;	
}