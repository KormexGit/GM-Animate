///feather ignore all

function __animation_effect() constructor {
	owner = other.id;
		
	static __animation_effect_get_index = function() {
		var _effect_array = owner.animations[track].effects;
		for (var i = 0, _len = array_length(_effect_array); i < _len; ++i) {
		    if _effect_array[i] == self {
				return i;
			}
		}
	}
	
	static __animation_channel_setup = function(_reverse_xy) {
		curve_progress = 0;
		rate = 1/duration;
		if !_reverse_xy {
			x_channel = animcurve_get_channel(curve, "x");
			y_channel = animcurve_get_channel(curve, "y");
		}
		else {
			x_channel = animcurve_get_channel(curve, "y");
			y_channel = animcurve_get_channel(curve, "x");
		}
	}
	
	static __animation_progress_curve = function() {
		curve_progress += rate;
		
		if curve_progress > 1 {
			if loop_count <= 1 {
				var _index = __animation_effect_get_index();
				array_delete(owner.animations[track].effects, _index, 1);
				return;
			}
			else {
				curve_progress = 0;	
				loop_count -= 1;
			}
		}	
	}
}

function __animation_effect_shake(_duration, _intensity, _track = 0) : __animation_effect() constructor {	
	duration = _duration;
	intensity = _intensity;
	track = _track;
	name = "shake";
	
	static step = function() {
		if duration <= 0 {
			var _index = __animation_effect_get_index();
			array_delete(owner.animations[track].effects, _index, 1);
			return;
		}
		duration -= 1;
		var _len = random_range(intensity/3, intensity);
		var _dir = random(360);
		owner.animations[track].x_offset += lengthdir_x(_len, _dir);
		owner.animations[track].y_offset += lengthdir_y(_len, _dir);
	}
}

function __animation_effect_squash_and_stretch(_duration, _scale, _loop_count, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	scale = _scale;
	loop_count = _loop_count;
	curve = _curve;
	track = _track;
	name = "squash_and_stretch";
	
	__animation_channel_setup(_reverse_xy);
	
	static step = function() {
		__animation_progress_curve();
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		var _y_prog = animcurve_channel_evaluate(y_channel, curve_progress);
		
		var _anim = owner.animations[track];
		_anim.xscale_offset += lerp(0, scale, _x_prog);
		_anim.yscale_offset += lerp(0, scale, _y_prog);
	}
}

function __animation_effect_pulse(_duration, _scale, _loop_count, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	scale = _scale;
	loop_count = _loop_count;
	curve = _curve;
	track = _track;
	name = "pulse";
	
	__animation_channel_setup(_reverse_xy);
	
	static step = function() {
		__animation_progress_curve();
		
		var _prog = animcurve_channel_evaluate(x_channel, curve_progress);
		
		var _anim = owner.animations[track];
		_anim.xscale_offset += lerp(0, scale, _prog);
		_anim.yscale_offset += lerp(0, scale, _prog);
	}
}

function __animation_effect_sway(_duration, _range, _x_offset, _y_offset, _loop_count, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	range = _range;
	x_offset = _x_offset;
	y_offset = _y_offset;
	loop_count = _loop_count;
	curve = _curve;
	track = _track;
	name = "sway";
	
	__animation_channel_setup(_reverse_xy);
	
	static step = function() {
		__animation_progress_curve();
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);		
		
		var _anim = owner.animations[track];
		var _angle = lerp(0, range, _x_prog);
		_anim.angle_offset += _angle;
		
		if x_offset != 0 or y_offset != 0 {
			var _offset_dist = point_distance(0, 0, x_offset, y_offset);
			var _offset_angle = point_direction(0, 0, x_offset, y_offset) + _anim.image_angle;
			
			var _effect_rotation_offset_x = lengthdir_x(_offset_dist, _offset_angle);
			var _effect_rotation_offset_y = lengthdir_y(_offset_dist, _offset_angle);
			_anim.x_offset += lengthdir_x(_offset_dist, _angle + _offset_angle + 180) + _effect_rotation_offset_x;
			_anim.y_offset += lengthdir_y(_offset_dist, _angle + _offset_angle + 180) + _effect_rotation_offset_y;
		}
	}
}

function __animation_effect_oscillate(_duration, _range, _direction, _loop_count, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	curve = _curve;
	range = _range;
	direction = _direction;
	loop_count = _loop_count;
	track = _track;
	name = "oscillate";
	
	__animation_channel_setup(_reverse_xy);
	
	static step = function() {
		__animation_progress_curve();
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		
		var _anim = owner.animations[track];
		var _offset = lerp(0, range, _x_prog);
		_anim.x_offset += lengthdir_x(_offset, direction);
		_anim.y_offset += lengthdir_y(_offset, direction);
	}
}

function __animation_effect_blink(_duration, _alpha_range, _loop_count, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	alpha_range = _alpha_range;
	loop_count = _loop_count;
	curve = _curve;
	reverse_xy = _reverse_xy;
	track = _track;
	name = "blink";
	
	__animation_channel_setup(_reverse_xy);
	
	static step = function() {
		__animation_progress_curve();
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		
		var _anim = owner.animations[track];
		var _offset = lerp(0, alpha_range, _x_prog);
		_anim.alpha_offset += abs(_offset);
	}
}

function __animation_effect_hitstop(_duration, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	track = _track;
	name = "hitstop";
	
	static step = function() {
		if duration <= 0 {
			var _index = __animation_effect_get_index();
			owner.animations[track].effect_pause = false;
			array_delete(owner.animations[track].effects, _index, 1);
			return;	
		}
		duration -= 1;
		owner.animations[track].effect_pause = true;
	}
}