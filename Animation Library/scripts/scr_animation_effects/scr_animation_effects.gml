function animation_shake(_duration, _intensity, _track = 0) {
	array_push(animations[_track].effects, new _animation_effect_shake(_duration, _intensity, _track));
}

function animation_squash_and_strech(_duration, _scale, _curve = anim_curve_bounce, _track = 0) {
	array_push(animations[_track].effects, new _animation_effect_squash_and_stretch(_duration, _scale, _curve, _track));
}

function animation_hitstop(_duration, _track = 0) {
	array_push(animations[_track].effects, new _animation_effect_hitstop(_duration, _track));
}