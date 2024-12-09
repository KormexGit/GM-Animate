function __animation_event(_frames, _callback, _track = 0) constructor {
	frames = _frames;
	callback = _callback;
}

function __animation_add_event(_sprite, _track, _event) {
		var _event_struct = animations[_track].events;
		var _sprite_name = sprite_get_name(_sprite);
		if !variable_struct_exists(_event_struct, _sprite_name) {
			_event_struct[$ _sprite_name] = [];
		}
		array_push(_event_struct[$ _sprite_name], _event);
	}
	
function __animation_add_event_to_sprite(_sprite, _track, _event) {
	if is_array(_sprite) {
		for(var i = 0, _len = array_length(_sprite); i < _len; i++) {
			__animation_add_event(_sprite[i], _track, _event);
		}
		return;
	}
	__animation_add_event(_sprite, _track, _event);
}

function __animation_remove_event(_event, _track) {
	var _events = animations[_track].events;
	var _names = variable_struct_get_names(_events);
	for(var j = array_length(_names) - 1; j > -1; j--) {
		var _sprite = _events[$ _names[j]];
		for(var k = array_length(_sprite) - 1; k > -1; k--) {
			if _sprite[k] == _event {
				array_delete(_sprite, k, 1);
			}
		}
		if array_length(_sprite) == 0 {
			variable_struct_remove(_events, _names[j]);	
		}
	}
}