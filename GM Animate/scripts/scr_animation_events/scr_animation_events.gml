

/// @desc Add an event. The callback method will be run when the current animation hits the specified frame. 
/// Note: the callback will run in the scope of the animation struct, not the calling instance. You can use `other` inside the method to refer to the calling instance.
/// @param {asset.GMSprite|Array} _sprite The sprite to add an event to. Can pass a single sprite, or an array of sprites to add the event to multiple at once.
/// @param {Real|Array} _frames The frames to run the callback on. Can pass a number, or an array of numbers to add the event for multiple frames at once.
/// @param {Function} _callback The function or method to run when the frame is reached.
/// @param {Real} _track The track to add the event to.
function animation_event_add(_sprite, _frames, _callback, _track = 0) {
	__animation_error_checks
	
	var _event = animations[_track].events;
	if is_array(_sprite) {
		for(var i = 0, _len = array_length(_sprite); i < _len; i++) {
			var _sprite_name = sprite_get_name(_sprite[i]);
			if !variable_struct_exists(_event, _sprite_name) {
				_event[$ _sprite_name] = [];
			}
			array_push(_event[$ _sprite_name], new __animation_event(_frames, method(self, _callback), _track));
		}
		return;
	}
	
	var _sprite_name = sprite_get_name(_sprite);
	if !variable_struct_exists(_event, _sprite_name) {
		_event[$ _sprite_name] = [];
	}
	array_push(_event[$ _sprite_name], new __animation_event(_frames, method(self, _callback), _track));
}

/// @desc Remove events from the specified sprite, frame, and track. Pass `all` for all three arguments to remove all events for this instance.
/// @param {asset.GMSprite|Array} _sprite The sprites to remove events from. Can pass a single sprite, or an array of sprites to remove events from multiple at once. Pass `all` to remove events from every sprite for this track.
/// @param {Real} _frames The frames to remove events from. Can pass a number, or an array of numbers to remove events from multiple frames at once. Pass `all` to remove all events for this sprite and track.
/// @param {Real} _track The track to remove events from. Pass `all` to remove events from every track.
function animation_event_remove(_sprite, _frames, _track = 0) {
	__animation_error_checks
	
	if _sprite == all and _frames == all and _track == all {
		for(var i = 0, _len = array_length(animations); i < _len; i++) {
			if animations[i] == 0 {
				continue;	
			}
			animations[i].events = {};
		}
	}
	
	if _track == all {
		for(var i = 0, _len = array_length(animations); i < _len; i++) {
			if animations[i] == 0 {
				continue;	
			}
		}
	}
}