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

function _animation_base() constructor {
	animate = function() {}
	draw = function() {}
	var ref = weak_ref_create(self);
	array_push(global._animation_array, ref);
}

function _animations(_sprite, _loop = true, _image_speed = 1) : _animation_base() constructor {
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
	
	x_offset = 0;
	y_offset = 0;
	xscale_offset = 0;
	yscale_offset = 0;
	angle_offset = 0;
	
	effects = [];
	
	static reset_offsets = function() {
		x_offset = 0;
		y_offset = 0;
		xscale_offset = 0;
		yscale_offset = 0;
		angle_offset = 0;
	}
	
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
		reset_offsets();
		for (var i = array_length(effects) - 1; i > -1; i--;) {
		    effects[i].step();
		}
	}
	
	draw = function(_x = other.x, _y = other.y) {
		draw_sprite_ext(sprite_index, image_index, _x + x_offset, _y + y_offset, image_xscale + xscale_offset, image_yscale + yscale_offset, 
		image_angle + angle_offset, image_blend, image_alpha);
	}
}

function animation_init() {
	animations = [];
}

function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new _animations(_sprite, _loop);
	return animations[_track];
}

function animation_draw(_x = x, _y = y, _track = 0) {
	if _animation_array_error() {
		return;	
	}
	if _animation_track_error(_track) {
		return;	
	}
	animations[_track].draw(_x, _y);
	return animations[_track];
}

function animation_get(_track) {
	if _animation_array_error() {
		return;	
	}
	if _animation_track_error(_track) {
		return;	
	}
	return animations[_track];	
}

function _animation_effect() constructor {
	owner = other.id;
		
	step = function() {};
	
	_animation_effect_get_index = function() {
		var effect_array = owner.animations[track].effects;
		for (var i = 0, len = array_length(effect_array); i < len; ++i) {
		    if effect_array[i] == self {
				return i;
			}
		}
	}
}

function _animation_effect_shake(_duration, _intensity, _track = 0) : _animation_effect() constructor {	
	duration = _duration;
	intensity = _intensity;
	track = _track;
	
	step = function() {
		if duration > 0 {
			duration -= 1;
			var len = random_range(intensity/3, intensity);
			var dir = random(360);
			owner.animations[track].x_offset += lengthdir_x(len, dir);
			owner.animations[track].y_offset += lengthdir_y(len, dir);
		}
		else {
			var index = _animation_effect_get_index();
			array_delete(owner.animations[track].effects, index, 1);
		}
	}
}

function _animation_effect_squash_and_stretch() : _animation_effect() constructor {
	
	
}

function animation_shake(_duration, _intensity, _track = 0) {
	array_push(animations[_track].effects, new _animation_effect_shake(_duration, _intensity, _track));
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

function animation_track_delete(_track) { 
	animations[_track] = 0;
}

