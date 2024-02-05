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
	name = "shake";
	
	step = function() {
		if duration <= 0 {
			var index = _animation_effect_get_index();
			array_delete(owner.animations[track].effects, index, 1);
			return;
		}
		duration -= 1;
		var len = random_range(intensity/3, intensity);
		var dir = random(360);
		owner.animations[track].x_offset += lengthdir_x(len, dir);
		owner.animations[track].y_offset += lengthdir_y(len, dir);
	}
}

function _animation_effect_squash_and_stretch(_duration, _scale, _curve, _track = 0) : _animation_effect() constructor {
	duration = _duration;
	curve = _curve;
	scale = _scale;
	track = _track;
	name = "squash_and_stretch";
	
	curve_progress = 0;
	rate = 1/duration;
	
	
	x_channel = animcurve_get_channel(curve, "x");
	y_channel = animcurve_get_channel(curve, "y");
	
	//starting_xscale = 0;
	//starting_yscale = 0;
	
	step = function() {
		if curve_progress >= duration/game_get_speed(gamespeed_fps) {
			var index = _animation_effect_get_index();
			array_delete(owner.animations[track].effects, index, 1);
			return;
		}
		curve_progress += rate;

		var x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		var y_prog = animcurve_channel_evaluate(y_channel, curve_progress);

		owner.animations[track].xscale_offset += lerp(0, scale, x_prog);
		owner.animations[track].yscale_offset += lerp(0, scale, y_prog);
	}
}

function _animation_effect_hitstop(_duration, _track = 0) : _animation_effect() constructor {
	duration = _duration;
	track = _track;
	name = "hitstop";
	
	step = function() {
		if duration <= 0 {
			var index = _animation_effect_get_index();
			owner.animations[track].effect_pause = false;
			array_delete(owner.animations[track].effects, index, 1);
			return;	
		}
		duration -= 1;
		owner.animations[track].effect_pause = true;
	}
}