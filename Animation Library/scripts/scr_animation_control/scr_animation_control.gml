function animation_init() {
	animations = [];
}

function animation_play(_sprite, _loop = true, _track = 0) {
	animations[_track] = new _animation(_sprite, _loop);
	return animations[_track];
}

/// Function Change an animation track to a different sprite without resetting effects or the queue
/// @param {any*} _sprite Description
/// @param {bool} [_loop]=true Description
/// @param {real} [_track]=0 Description
///
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

function animation_get(_track = 0) {
	__animation_error_checks
	
	return animations[_track];	
}

function animation_remove(_track) { 
	animations[_track] = 0;
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

function animation_set_looping(_loop, _track = 0) {
	animations[_track].loop = _loop;
}

function animation_get_looping(_track = 0) {
	return animations[_track].loop;
}