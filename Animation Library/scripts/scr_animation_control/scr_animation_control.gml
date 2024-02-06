/// @desc Plays an animation. 
/// Creates a new animation struct, so if the specified track already has an animation playing, 
/// effects, the animation queue, and variable changes will be reset.
/// Use animation_change instead to change the sprite without resetting things.
/// @param {asset.GMSprite} _sprite The sprite asset to animate.
/// @param {Bool} _loop Whether the animation should loop or not upon completion.
/// @param {Real} _track The track to play the animation on.
function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new __animation(_sprite, _loop);
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
/// @param {Real} _track The track to draw. Accepts `all`
function animation_draw(_x = x, _y = y, _track = 0) {
	__animation_error_checks
	
	if _track == all {
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    animations[i].draw(_x, _y);
		}
		return;
	}		
	animations[_track].draw(_x, _y);
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
/// @param {Real} _track The track to get. Accepts `all`
function animation_get(_track = 0) {
	__animation_error_checks
	if _track == all {
		return animations;	
	}
	return animations[_track];	
}

/// @desc Returns whether an animation exists on the specified track.
/// @param {Real} _track The track to check.
function animation_exists(_track = 0) {
	if !variable_instance_exists(id, "animations") { 
		return false;
	}
	if array_length(animations) <= _track or animations[_track] == 0 {
		return false;	
	}
	if instanceof(animations[_track]) == "__animation" {
		return true;	
	}
	return false;
}

/// @desc Removes an animation track, deleting it entirely.
/// @param {Real} _track The track to delete. Accepts `all`
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

/// @desc Checks if an animation finished this frame.
/// @param {Real} _track The track to check.
function animation_finished(_track = 0) {
	__animation_error_checks
	
	return animations[_track].finished;
}

/// @desc Check if an animation is currently on the specified frame. Can return true multiple steps in a row.
/// @param {Real} _frame The frame to check.
/// @param {Real} _track The track to check.
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

/// @desc Check if an animation is arrived at the specified frame this step. Will only return true the first step it arrives at that frame.
/// @param {Real} _frame The frame to check.
/// @param {Real} _track The track to check.
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

/// @desc Pauses or unpauses the global animation timesource. This will pause ALL animations, including ones started after calling this function.
/// @param {Bool} _pause Whether to pause or unpause. 
function animation_set_global_pause(_pause) {
	if _pause == true {
		time_source_pause(global._animation_timesource);
	}
	else if _pause == false {
		time_source_resume(global._animation_timesource);
	}
}

/// @desc Returns whether the global animation timesource is currently paused or unpaused.
function animation_get_global_pause() {
	var _state = time_source_get_state(global._animation_timesource);
	if _state == time_source_state_paused {
		return true;	
	}
	return false;
}

/// @desc Pauses or unpauses all animations that currently exist in the whole game. This will not pause new calls of animation_play that happen after.
/// Good choice over animation_set_global_pause if you want to pause gameplay sprites and still use the animation system for pause menu elements.
/// @param {Bool} _pause Whether to pause or unpause. 
function animation_set_pause_all(_pause) {
	for (var i = 0, len = array_length(global._animation_array); i < len; i++;){
		if weak_ref_alive(global._animation_array[i]) {
			global._animation_array[i].ref.paused = _pause;
		}
	}
}

/// @desc Pauses or unpauses the animation on the specified track. Pass `all` as the track to set all tracks at once.
/// @param {Bool} _pause Whether to pause or unpause. 
/// @param {Real} _track The track to set.
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

/// @desc Checks if the specified track is currently paused or not. Pass `all` as the track to check if every track is paused.
/// @param {Real} _track The track to check. Accepts `all`
function animation_get_pause(_track = 0) {
	__animation_error_checks
	
	if _track == all {
		var _all_paused = true;
		for (var i = 0, len = array_length(animations); i < len; ++i) {
		    if animations[i] != 0 {
				if animations[i].paused == false {
					return false;	
				}
			}
		}
		return _all_paused;
	}
	return animations[_track].paused;
}

/// @desc Sets looping for the animation on the specified track. Pass `all` as the track to set all tracks at once.
/// @param {Bool} _loop Whether to loop or stop looping.
/// @param {Real} _track The track to set. Accepts `all`
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

/// @desc Checks if the specified track is currently looping or not.
/// @param {Real} _track The track to check.
function animation_get_looping(_track = 0) {
	__animation_error_checks
	
	return animations[_track].loop;
}