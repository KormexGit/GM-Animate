//feather ignore all

/// @desc Starts a shake effect for the specified track.
/// @param {Real} _duration How long the shake should last, in steps/game frames.
/// @param {Real} _intensity How strong the shake should be. This value is be the max distance the animation will move during the shake, measured in pixels.
/// @param {Real} _track The track to apply the effect to. Pass `all` to apply the effect to all tracks at once.
function animation_effect_shake(_duration, _intensity, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_shake(_duration, _intensity, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_shake(_duration, _intensity, _track));
}

/// @desc Starts a squash and stretch effect for the specified track. 
/// @param {Real} _duration How long the squash and stretch should last, in steps/game frames.
/// @param {Real} _scale How big the squash and stretch should be. This value is the size of the largest part of the squash or stretch,
/// as an image_xscale and image_yscale multiplier. For example, a scale of 0.5 would make the largest stretch be 50% larger. 
/// In most cases, you will want a value that is in between 0.1 and 0.9. 
/// A value higher than the animations's current image_xscale or image_yscale may cause the animation to overshoot the squash and flip.
/// @param {Asset.GMAnimCurve} _curve The animation curve asset to base the squash and stretch on. See the Animation Curves folder inside the Animation folder
/// in the asset browser for some curves you can use, or make your own using the same format as the included ones. 
/// @param {Bool} _reverse_xy Reverses the x and y tracks in the animation curve. If set to true, the x track will be applied to image_yscale
/// and the y track applied to image_xscale.
/// @param {Real} _track The track to apply the effect to. Pass `all` to apply the effect to all tracks at once.
function animation_effect_squash_and_strech(_duration, _scale, _curve = animation_curve_wave, _reverse_xy = false, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_squash_and_stretch(_duration, _scale, _curve, _reverse_xy, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_squash_and_stretch(_duration, _scale, _curve, _reverse_xy, _track));
}

/// @desc Starts a sway effect for the specified track. 
/// @param {Real} _duration How long the sway should last, in steps/game frames.
/// @param {Real} _range How the sway should rotate, measured in degrees.
/// @param {Real} _x_offset Offsets the x origin of the rotation, relative to the sprite's actual origin.
/// @param {Real} _y_offset Offsets the y origin of the rotation, relative to the sprite's actual origin.
/// These allows you to do things like have the rotation of the sway be based on the bottom of the sprite even if the sprite has a centered origin.
/// @param {Asset.GMAnimCurve} _curve The animation curve asset to base the sway on. See the Animation Curves folder inside the Animation folder.
/// in the asset browser for some curves you can use, or make your own using the same format as the included ones. 
/// Only the "x" channel is used by this effect.
/// @param {Bool} _reverse_xy Reverses the x and y tracks in the animation curve. If set to true, the "y" channel will be used instead of the "x" channel.
/// @param {Real} _track The track to apply the effect to. Pass `all` to apply the effect to all tracks at once.
function animation_effect_sway(_duration, _range, _x_offset = 0, _y_offset = 0, _curve = animation_curve_bounce_once, _reverse_xy = false, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_sway(_duration, _range, _x_offset, _y_offset, _curve, _reverse_xy, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_sway(_duration, _range, _x_offset, _y_offset, _curve, _reverse_xy, _track));
}

/// @desc Starts a float effect for the specified track. 
/// @param {Real} _duration How long the float should last, in steps/game frames. If loop is set to true, this will be the duration of each loop.
/// @param {Real} _range How big the float should be, measured in pixels.
/// @param {Real} _direction The direction the animation should float in. The pixel range will be applied in this direction.
/// @param {Bool} _loop Whether the effect should loop or not.
/// @param {Asset.GMAnimCurve} _curve The animation curve asset to base the float on. See the Animation Curves folder inside the Animation folder
/// in the asset browser for some curves you can use, or make your own using the same format as the included ones. 
/// Only the "x" channel is used by this effect.
/// @param {Bool} _reverse_xy Reverses the x and y tracks in the animation curve. If set to true, the "y" channel will be used instead of the "x" channel.
/// @param {Real} _track The track to apply the effect to. Pass `all` to apply the effect to all tracks at once.
function animation_effect_float(_duration, _range, _direction = 90, _loop = false, _curve = animation_curve_bounce_once, _reverse_xy = false, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_float(_duration, _range, _direction, _loop, _curve, _reverse_xy, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_float(_duration, _range, _direction, _loop, _curve, _reverse_xy, _track));
}

/// @desc Starts a hitstop effect for the specified track. This will stop the track from animating for the duration,
/// but will not stop effects from running. 
/// @param {Real} _duration How long the hitstop should last, steps/game frames.
/// @param {Real} _track The track to apply the effect to. Pass `all` to apply the effect to all tracks at once.
function animation_effect_hitstop(_duration, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				array_push(animations[i].effects, new __animation_effect_hitstop(_duration, i));
			}
		}
		return;
	}
	array_push(animations[_track].effects, new __animation_effect_hitstop(_duration, _track));
}


/// @desc Counts how many instances of an effect are active on the specified track.
/// @param {String} _effect_name The name of the effect to count, as a string. Effect names: "shake", "squash_and_stretch", "hitstop"
/// @param {Real} _track The track to count effects from. Pass `all` to add up how many of the effect is active across all tracks.
/// @return {Real} How many of the specified effect is currently active.
function animation_effect_get_count(_effect_name, _track = 0) {
	__animation_error_checks
	
	if _track == all {
		var _effect_count = 0;
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
			var _effects = animations[i].effects;
			for (var j = 0, _len2 = array_length(_effects); j < _len2; ++j) {
			    if _effects[j].name == _effect_name {
					_effect_count += 1;
				}
			}
		}
		return _effect_count;
	}	
	var _effects = animations[_track].effects;
	var _effect_count = 0;
	for (var i = 0, _len = array_length(_effects); i < _len; ++i) {
	    if _effects[i].name == _effect_name {
			_effect_count += 1;
		}
	}
	return _effect_count;
}

/// @desc Cancels all instances of an effect on the specified track.
/// @param {String} _effect_name The name of the effect to cancel, as a string. Effect names: "shake", "squash_and_stretch", "hitstop"
/// @param {Real} _track The track cancel effects on. Pass `all` to cancel the effect on every track.
function animation_effect_cancel(_effect_name, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; i++;) {
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