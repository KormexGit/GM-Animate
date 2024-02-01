function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new _animation(_sprite, _loop);
	return animations[_track];
}

/// Function Change an animation track to a different sprite without resetting effects or the queue
/// @param {any*} _sprite Description
/// @param {bool} [_loop]=true Description
/// @param {real} [_track]=0 Description
function animation_change(_sprite, _loop = true, _track = 0) {
	__animation_error_checks
	
	/// feather ignore once GM1049
	with animations[_track] {
		sprite_index = _sprite;
		loop = _loop;
		__animation_variable_setup();
	}
}

function animation_draw(_x = x, _y = y, _track = 0) {
	__animation_error_checks
	
	animations[_track].draw(_x, _y);
	return animations[_track];	
}

function animation_mask_sync(_track) {
	
}

function animation_get(_track = 0) {
	__animation_error_checks
	
	return animations[_track];	
}

function animation_exists(_track = 0) {
	if array_length(animations) <= _track or animations[_track] == 0 {
		return false;	
	}
	if instanceof(animations[_track]) == "_animation" {
		return true;	
	}
	return false;
}

function animation_remove(_track) {
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


function animation_set_pause_all(_pause) {
	if _pause == true {
		time_source_pause(global._animation_timesource);
	}
	else if _pause == false {
		time_source_resume(global._animation_timesource);
	}
}

function animation_get_pause_all() {
	var _state = time_source_get_state(global._animation_timesource);
	if _state == time_source_state_paused {
		return true;	
	}
	return false;
}

function animation_set_pause(_pause, _track = 0) {
	__animation_error_checks
	
	animations[_track].paused = _pause;
}

function animation_get_pause(_track = 0) {
	__animation_error_checks
	
	return animations[_track].paused;
}

function animation_set_looping(_loop, _track = 0) {
	__animation_error_checks
	
	animations[_track].loop = _loop;
}

function animation_get_looping(_track = 0) {
	__animation_error_checks
	
	return animations[_track].loop;
}