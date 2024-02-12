
/// @desc Pauses or unpauses the global animation timesource. This will pause ALL animations, including ones started after calling this function.
/// @param {Bool} _pause Whether to pause or unpause. 
function animation_set_global_pause(_pause) {
	if _pause == true {
		time_source_pause(global.__animation_timesource);
	}
	else if _pause == false {
		time_source_resume(global.__animation_timesource);
	}
}

/// @desc Checks whether the global animation timesource is currently paused or not.
/// @return {Bool} Whether the global animation timesource is currently paused or not.
function animation_get_global_pause() {
	var _state = time_source_get_state(global.__animation_timesource);
	if _state == time_source_state_paused {
		return true;	
	}
	return false;
}

/// @desc Pauses or unpauses all animations that currently exist in the whole game. Will not pause newly played animations that start after this is called.
/// Good choice over animation_set_global_pause if you want to pause gameplay sprites but still use the animation system for a pause menu.
/// @param {Bool} _pause Whether to pause or unpause. 
function animation_set_pause_all(_pause) {
	for (var i = 0, _len = array_length(global.__animation_array); i < _len; i++;){
		if weak_ref_alive(global.__animation_array[i]) {
			global.__animation_array[i].ref.paused = _pause;
		}
	}
}

/// @desc Pauses or unpauses the animation on the specified track.
/// @param {Bool} _pause Whether to pause or unpause. 
/// @param {Real} _track The track to set. Pass `all` to set all tracks at once.
function animation_set_pause(_pause, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] != 0 {
				animations[i].paused = _pause;	
			}
		}
		return;
	}
	animations[_track].paused = _pause;
}

/// @desc Checks if the specified track is paused or not. Does not work for a global time source pause.
/// @param {Real} _track The track to check. Pass `all` to check if every track is paused at the same time.
/// @return {Bool} Whether the specified track(s) are paused or not.
function animation_get_pause(_track = 0) {
	__animation_error_checks
	
	if _track == all {
		var _all_paused = true;
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
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