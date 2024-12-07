//feather ignore all

/// @desc Add an event. The callback method will be run when the current animation hits the specified frame. 
/// Note: the callback will run in the scope of the animation struct, not the calling instance. You can use `other` inside the method to refer to the calling instance.
/// @param {asset.GMSprite|Array} _sprite The sprite to add an event to. Can pass a single sprite, or an array of sprites to add the event to multiple at once.
/// @param {Real|Array} _frames The frames to run the callback on. Can pass a number, or an array of numbers to add the event for multiple frames at once.
/// @param {Function} _callback The function or method to run when the frame is reached.
/// @param {Struct|Id.Instance} _callback_scope The scope the callback function should run in. Defaults to the calling instance.
/// @param {Real} _track The track to add the event to.
function animation_event_add(_sprite, _frames, _callback, _callback_scope = self, _track = 0) {
	__animation_error_checks
	
	var _event = new __animation_event(_frames, method(_callback_scope, _callback), _track);
	
	if _track == all {
		for(var i = 0, _len = array_length(animations); i < _len; i++) {
			if animations[i] == 0 {
				continue;	
			}
			__animation_add_event_to_sprite(_sprite, i, _event);
		}
		return _event;
	}
	
	__animation_add_event_to_sprite(_sprite, _track, _event);
	
	return _event;
}


/// @desc Removes an event from the specified track.
/// @param {Struct} _event The event to remove. Should be an event struct returned by animation_event_add.
/// @param {Real} _track The track to remove events from. Pass `all` to remove the event from every track.
function animation_event_remove(_event, _track = 0) {
	__animation_error_checks
	
	if _track == all {
		for(var i = 0, _len = array_length(animations); i < _len; i++) {
			if animations[i] == 0 {
				continue;	
			}
			__animation_remove_event(_event, i);
		}
		return;
	}
	__animation_remove_event(_event, _track);
}

/// @desc Removes all events for this instance.
function animation_event_remove_all() {
	__animation_array_error();
	
	for(var i = 0, _len = array_length(animations); i < _len; i++) {
		if animations[i] == 0 {
			continue;	
		}
		animations[i].events = {};
	}
}

