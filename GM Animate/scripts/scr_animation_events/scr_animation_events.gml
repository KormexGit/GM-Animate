/// @desc Add an event. The callback method will be run when the current animation hits the specified frame. 
/// Note: the callback will run in the scope of the animation struct, not the calling instance. You can use `other` inside the method to refer to the calling instance.
/// @param {Real} _frame The frame to run the callback on.
/// @param {Function} _callback The function/method to run when the frame is reached.
/// @param {Real} _track The track to add the event to.
function animation_event_add(_frame, _callback, _track = 0) {
	__animation_error_checks
	array_push(animations[_track].events, new __animation_event(_frame, _callback, _track));
}

/// @desc Remove all events from the specified frame.
/// @param {Real} _frame The frame to remove events from. Pass `all` to remove all events from this track.
/// @param {Real} _track The track to remove events from.
function animation_event_remove(_frame, _track = 0) {
	__animation_error_checks
	if _frame == all {
		array_resize(animations[_track].events, 0);
		return;
	}
	var _events = animations[_track].events;
	for (var i = array_length(_events) - 1; i > -1; i--) {
	    if _events.frame == _frame {
			array_delete(_events, i, 1);	
		}
	}
}