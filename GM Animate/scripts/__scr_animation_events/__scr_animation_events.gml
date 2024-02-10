function __animation_event(_frame, _callback, _track) constructor {
	frame = _frame;
	callback = method(other.animations[_track], _callback);
}

function animation_event_add(_frame, _callback, _track = 0) {
	__animation_error_checks
	array_push(animations[_track].events, new __animation_event(_frame, _callback, _track));
}

function animation_event_remove(_frame, _track = 0) {
	var _events = animations[_track].events;
	for (var i = array_length(_events) - 1; i > -1; i--) {
	    if _events.frame == _frame {
			array_delete(_events, i, 1);	
		}
	}
}