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

function __animation_effect_squash_and_stretch(_duration, _scale, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	curve = _curve;
	scale = _scale;
	track = _track;
	name = "squash_and_stretch";
	
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
	
	static step = function() {
		curve_progress += rate;
		
		if curve_progress > 1 {
			var _index = __animation_effect_get_index();
			array_delete(owner.animations[track].effects, _index, 1);
			return;
		}
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		var _y_prog = animcurve_channel_evaluate(y_channel, curve_progress);
		
		var _anim = owner.animations[track];
		_anim.xscale_offset += lerp(0, scale, _x_prog);
		_anim.yscale_offset += lerp(0, scale, _y_prog);
	}
}

function __animation_effect_sway(_duration, _range, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	curve = _curve;
	range = _range;
	track = _track;
	name = "sway";
	
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
	
	static step = function() {
		curve_progress += rate;
		
		if curve_progress > 1 {
			var _index = __animation_effect_get_index();
			array_delete(owner.animations[track].effects, _index, 1);
			return;
		}
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		
		var _anim = owner.animations[track];
		_anim.angle_offset += lerp(0, range, _x_prog);
	}
}

function __animation_effect_float(_duration, _range, _direction, _loop, _curve, _reverse_xy, _track = 0) : __animation_effect() constructor {
	duration = _duration;
	curve = _curve;
	range = _range;
	direction = _direction;
	loop = _loop;
	track = _track;
	name = "float";
	
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
	
	static step = function() {
		curve_progress += rate;
		
		if curve_progress > 1 {
			if loop == false {
				var _index = __animation_effect_get_index();
				array_delete(owner.animations[track].effects, _index, 1);
				return;
			}
			else {
				curve_progress = 0;	
			}
		}
		
		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		
		var _anim = owner.animations[track];
		var _offset = lerp(0, range, _x_prog);
		_anim.x_offset += lengthdir_x(_offset, direction);
		_anim.y_offset += lengthdir_y(_offset, direction);
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