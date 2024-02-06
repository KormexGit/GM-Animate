function animation_shake(_duration, _intensity, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_shake(_duration, _intensity, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_shake(_duration, _intensity, _track));
}

function animation_squash_and_strech(_duration, _scale, _curve = anim_curve_bounce, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_squash_and_stretch(_duration, _scale, _curve, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_squash_and_stretch(_duration, _scale, _curve, _track));
}

function animation_hitstop(_duration, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_hitstop(_duration, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_hitstop(_duration, _track));
}

function animation_get_effect_count(_effect_name, _track = 0) {
	__animation_error_checks
	var _effects = animations[_track].effects;
	var _effect_count = 0;
	for (var i = 0, len = array_length(_effects); i < len; ++i) {
	    if _effects[i].name == _effect_name {
			_effect_count += 1;
		}
	}
	return _effect_count;
}

function animation_effect_cancel(_effect_name, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; i++;) {
			if animations[i] == 0 {
				continue;	
			}
			var _effects = animations[i].effects;
			for (var j = array_length(_effects) - 1; j > -1; j--;) {
			    if _effects[j].name == _effect_name {
					array_delete(_effects, j, 1);
				}
			}
		}
		return;
	}
	var _effects = animations[_track].effects;
	for (var i = array_length(_effects) - 1; i > -1; i--;) {
		if _effects[i].name == _effect_name {
			array_delete(_effects, i, 1);
		}
	}
}