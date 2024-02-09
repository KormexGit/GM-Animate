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
		if curve_progress >= duration/game_get_speed(gamespeed_fps) {
			var _index = __animation_effect_get_index();
			array_delete(owner.animations[track].effects, _index, 1);
			return;
		}
		curve_progress += rate;

		var _x_prog = animcurve_channel_evaluate(x_channel, curve_progress);
		var _y_prog = animcurve_channel_evaluate(y_channel, curve_progress);
		
		var anim = owner.animations[track];
		anim.xscale_offset += (lerp(0, scale, _x_prog) * sign(anim.image_xscale));
		anim.yscale_offset += (lerp(0, scale, _y_prog) * sign(anim.image_yscale));
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