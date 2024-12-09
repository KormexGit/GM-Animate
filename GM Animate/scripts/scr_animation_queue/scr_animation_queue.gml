/// @desc Adds a sprite to the end of the animation queue.
/// @param {asset.GMSprite} _sprite The sprite to add to the queue.
/// @param {Bool} _loop Whether the queued animation should loop when it finishes. Note: if there are more animations queued after this one,
/// then this argument won't make a difference.
/// @param {Real} _track The track to queue the animation for.
function animation_queue_add(_sprite, _loop = true, _track = 0) {
	__animation_error_checks
	
	array_push(animations[_track].queue, {
		sprite_index : _sprite,
		loop : _loop
	});	
}

/// @desc Inserts a sprite into the specified position in the queue.
/// @param {asset.GMSprite} _sprite The sprite asset to add to the queue.
/// @param {Real} _index The position in the queue to insert the animation into.
/// @param {Bool} _loop Whether the queued animation should loop when it finishes. Note: if there are more animations queued after this one,
/// then this argument won't make a difference.
/// @param {Real} _track The track to queue the animation for.
function animation_queue_insert(_sprite, _index, _loop = true, _track = 0) {
	__animation_error_checks
	
	if _index > array_length(animations[_track].queue) {
		animation_queue_add(_sprite, _loop, _track);
		return;
	}
	array_insert(animations[_track].queue, _index, {
		sprite_index : _sprite,
		loop : _loop
	});	
}

/// @desc Clears the animation queue, removing all queued animations.
/// @param {Real} _track The track of the queue to clear.
function animation_queue_clear(_track = 0) {
	__animation_error_checks
	
	array_resize(animations[_track].queue, 0);
}

/// @desc Removes whatever sprite is in the queue at the specified position.
/// @param {Real} _index The position to remove.
/// @param {Real} _track The track of the queue to remove from.
function animation_queue_remove_index(_index, _track = 0) {
	__animation_error_checks
	
	var _queue = animations[_track].queue;
	if array_length(_queue) - 1 >= _index {
		array_delete(_queue, _index, 1);
	}
	else {
		show_debug_message("GM Animate Warning: tried to use animation_queue_remove_index on an index that didn't exist. Object: " +
		object_get_name(object_index) + ", index: " + string(_index) + ", queue length: " + string(animation_queue_get_length(_track)));	
	}
}

/// @desc Removes a sprite from the queue. If the sprite has been queued multiple times, all of them will be removed.
/// @param {asset.GMSprite} _sprite The sprite to remove.
/// @param {Real} _track The track of the queue to remove from.
function animation_queue_remove_sprite(_sprite, _track = 0) {
	__animation_error_checks
	
	var _queue = animations[_track].queue;
	for (var i = array_length(queue) - 1; i > -1; i--) {
	    if _queue[i].sprite_index == _sprite {
			array_delete(_queue, i, 1);
		}
	}
}

/// @desc Returns how the number of queued animations.
/// @param {Real} _track The track of the queue to check.
/// @return {Real} The length of the specified queue.
function animation_queue_get_length(_track = 0) {
	__animation_error_checks
	
	return array_length(animations[_track].queue);
}

/// @desc Returns an array of all queued sprites.
/// @param {Real} _track The track of the queue to check.
/// @return {Array<Any>} An array of all currently queued sprites.
function animation_queue_get(_track = 0) {
	__animation_error_checks	
	var _array = [];
	var _queue = animations[_track].queue;
	for (var i = 0, _len = array_length(queue); i < _len; ++i) {
	    _array[i] = _queue[i].sprite_index;
	}
	return _array;
}

/// @desc Returns the first position in the queue that the specified sprite is at. Returns -1 if the sprite is not present in the queue.
/// @param {asset.GMSprite} _sprite The sprite to check for.
/// @param {Real} _track The track of the queue to check.
/// @return {Real} The index the specified sprite is present in, or -1 if the sprite is not present.
function animation_queue_get_index(_sprite, _track = 0) {
	__animation_error_checks
	
	var _queue = animations[_track].queue;
	for (var i = 0, _len = array_length(_queue); i < _len; ++i) {
	    if _queue[i].sprite_index == _sprite {
			return i;
		}
	}
	return -1;
}

/// @desc Returns an array of all positions in the queue that the specified sprite is at. Returns -1 if the sprite is not present in the queue.
/// @param {asset.GMSprite} _sprite The sprite to check for.
/// @param {Real} _track The track of the queue to check.
/// @return {Array<Real>} An array of all indexes the sprite is present in.
function animation_queue_get_all_indexes(_sprite, _track = 0) {
	__animation_error_checks
	
	var _positions = [];
	var _queue = animations[_track].queue;
	for (var i = 0, _len = array_length(_queue); i < _len; ++i) {
	    if queue[i].sprite_index == _sprite {
			array_push(_positions, i);	
		}
	}
	return _positions;
}