/// @desc Plays an animation. 
/// Creates a new animation struct, so if the specified track already has an animation playing, 
/// effects, the animation queue, and variable changes will be reset.
/// Use animation_change instead to change the sprite without resetting things.
/// @param {asset.GMSprite} _sprite The sprite asset to animate.
/// @param {Bool} _loop Whether the animation should loop or not upon completion.
/// @param {Real} _track The track to play the animation on.
function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new _animation(_sprite, _loop);
	return animations[_track];
}

/// @desc Change an animation track to a different sprite without resetting effects, the animation queue, or variables.
/// The equivalent of changing sprite_index when using GameMaker's built in animation.
/// @param {asset.GMSprite} _sprite The sprite asset to animate.
/// @param {Bool} _loop Whether the animation should loop or not upon completion.
/// @param {Real} _track The track to play the animation on.
function animation_change(_sprite, _loop = true, _track = 0) {
	__animation_error_checks
	
	/// feather ignore once GM1049
	with animations[_track] {
		sprite_index = _sprite;
		loop = _loop;
		__animation_variable_setup();
	}
}

/// @desc Draw an animation. Should always be called in a draw related event.
/// @param {Real} _x x coordinate.
/// @param {Real} _y y coordinate.
/// @param {Real} _track The track to play the animation on.
function animation_draw(_x = x, _y = y, _track = 0) {
	__animation_error_checks
	
	animations[_track].draw(_x, _y);
	return animations[_track];	
}

/// @desc Set the instance's collision mask to match the specified animation track.
/// WARNING: _use_scale and _use_angle will change the calling instance's image_xscale, image_yscale, and/or image_angle if set to true. 
/// @param {Bool} _use_scale Whether to match the instance's image_xscale and image_yscale to the animation's image_xscale and image_yscale. 
/// @param {Bool} _use_angle Whether to match the instance's image_angle to the animation's image_angle. 
/// @param {Real} _track The track to get the sprite from to use as the collision mask.
function animation_set_instance_mask(_use_scale, _use_angle, _track = 0) {
	var anim = animations[_track];
	mask_index = anim.sprite_index;
	if _use_scale == true {
		image_xscale = anim.image_xscale;
		image_yscale = anim.image_yscale;
	}
	if _use_angle == true {
		image_angle = anim.image_angle;	
	}
}

/// @desc Returns the animation struck on the specified track. If all is passed as the track, it will return the full animation array.
/// @param {Real} _track The track to get the sprite from to use as the collision mask.
function animation_get(_track = 0) {
	__animation_error_checks
	if _track == all {
		return animations;	
	}
	return animations[_track];	
}

function animation_exists(_track = 0) {
	if !variable_instance_exists(id, "animations") { 
		return false;
	}
	if array_length(animations) <= _track or animations[_track] == 0 {
		return false;	
	}
	if instanceof(animations[_track]) == "_animation" {
		return true;	
	}
	return false;
}

function animation_remove(_track) {
	if _track == all {
		animations = [];
		return;
	}
	animations[_track] = 0;
	for (var i = array_length(animations) - 1; i > -1; i--;) {
	    if animations[i] == 0 {
			array_delete(animations, i, 1);	
		}
		else {
			break;	
		}
	}
}

function animation_finished(_track = 0) {
	__animation_error_checks
	
	return animations[_track].finished;
}

function animation_on_frame(_frame, _track = 0) {
	if is_array(_frame) {
		for (var i = 0, len = array_length(_frame); i < len; ++i) {
			if floor(animations[_track].image_index) == _frame[i] {
				return true;	
			}
		}
	}
	else if floor(animations[_track].image_index) == _frame {
		return true;	
	}
}

function animation_arrived_at_frame(_frame, _track = 0) {
	if is_array(_frame) {
		for (var i = 0, len = array_length(_frame); i < len; ++i) {
			if animations[_track].new_frame == _frame[i] {
				return true;	
			}
		}
	}
	else if animations[_track].new_frame == _frame {
		return true;	
	}
}

function animation_set_global_pause(_pause) {
	if _pause == true {
		time_source_pause(global._animation_timesource);
	}
	else if _pause == false {
		time_source_resume(global._animation_timesource);
	}
}

function animation_get_global_pause() {
	var _state = time_source_get_state(global._animation_timesource);
	if _state == time_source_state_paused {
		return true;	
	}
	return false;
}

function animation_set_pause_all(_pause) {
	for (var i = 0, len = array_length(global._animation_array); i < len; i++;){
		if weak_ref_alive(global._animation_array[i]) {
			global._animation_array[i].ref.paused = _pause;
		}
	}
}

function animation_set_pause(_pause, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				animations[i].paused = _pause;	
			}
		}
		return;
	}
	animations[_track].paused = _pause;
}

function animation_get_pause(_track = 0) {
	__animation_error_checks
	
	return animations[_track].paused;
}

function animation_set_looping(_loop, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				animations[i].loop = _pause;	
			}
		}
		return;
	}

	
	animations[_track].loop = _loop;
}

function animation_get_looping(_track = 0) {
	__animation_error_checks
	
	return animations[_track].loop;
}