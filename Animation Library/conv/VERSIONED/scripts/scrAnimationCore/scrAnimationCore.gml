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

function animation_base() constructor {
	animate = function() {}
	draw = function() {}
	var ref = weak_ref_create(self);
	array_push(global._animationArray, ref);
}

function animation(_sprite, _loop = true, _image_speed = 1) : animation_base() constructor {
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
}

function animation_init() {
	animations = [];
}

function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new animation(_sprite, _loop);
	return animations[_track];
}

function animation_draw(_x = x, _y = y, _track = 0) {
	_animation_array_error
	if _animation_track_error(_track) {
		return;	
	}
	animations[_track].draw(_x, _y);
	return animations[_track];
}

function animation_get(_track) {
	_animation_array_error
	if _animation_track_error(_track) {
		return;	
	}
	return animations[_track];	
}

function _animation_track_error(_track) {
	if _track > array_length(animations) - 1 or animations[_track] == 0 {
		show_debug_message("Warning! Tried to access a track that does not exist on " + object_get_name(object_index) + ", track number " + string(_track)); 
		return true;
	}
}

function animation_track_delete(_track) { 
	animations[_track] = 0;
}

