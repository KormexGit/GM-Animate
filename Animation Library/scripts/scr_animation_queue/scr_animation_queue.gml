function animation_queue_add(_sprite, _loop = true, _track = 0) {
	array_push(animations[_track].queue, {
		sprite_index : _sprite,
		loop : _loop
	});	
}

function animation_queue_insert(_sprite, _index, _loop = true, _track = 0) {
	array_insert(animations[_track].queue, _index, {
		sprite_index : _sprite,
		loop : _loop
	});	
}

function animation_queue_remove_sprite(_sprite, _track = 0) {
	var queue = animations[_track].queue;
	for (var i = array_length(queue) - 1; i > -1; i--) {
	    if queue[i].sprite_index == _sprite {
			array_delete(queue, i, 1);
		}
	}
}

function animation_queue_remove_index(_index, _track = 0) {
	var queue = animations[_track].queue;
	if array_length(queue) - 1 >= _index {
		array_delete(queue, _index, 1);
	}
	else {
		show_debug_message("Animation warning: tried to use animation_queue_remove_index on an index that didn't exist");	
	}
}


function animation_queue_clear(_track = 0) {
	array_resize(animations[_track].queue, 0);
}

function animation_queue_get_length(_track = 0) {
	return array_length(animations[_track].queue);
}

function animation_queue_get_array(_track = 0) {
	return animations[_track].queue;	
}

//returns the first position an animation is in
function animation_queue_get_index(_sprite, _track = 0) {
	var queue = animations[_track].queue;
	for (var i = 0, len = array_length(queue); i < len; ++i) {
	    if queue[i].sprite_index == _sprite {
			return i;
		}
	}
	return -1;
}

function animation_queue_get_all_index(_sprite, _track = 0) {
	var positions = [];
	var queue = animations[_track].queue;
	for (var i = 0, len = array_length(queue); i < len; ++i) {
	    if queue[i].sprite_index == _sprite {
			array_push(positions, i);	
		}
	}
	return positions;
}