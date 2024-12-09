/// @desc Pauses or unpauses the animation on the specified track.
/// @param {Bool} _pause Whether to pause or unpause. 
/// @param {Real} _track The track to set. Pass `all` to set all tracks at once.
function animation_set_pause(_pause, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] == 0 {
				continue;
			}
			animations[i].paused = _pause;	
		}
		return;
	}
	animations[_track].paused = _pause;
}

/// @desc Checks if the specified track is paused or not.
/// @param {Real} _track The track to check. Pass `all` to check if every track is paused.
/// @return {Bool} Whether the specified track(s) are paused or not.
function animation_get_pause(_track = 0) {
	__animation_error_checks
	
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] == 0 {
				continue;
			}
			if animations[i].paused == false {
				return false;	
			}
		}
		return true;
	}
	return animations[_track].paused;
}