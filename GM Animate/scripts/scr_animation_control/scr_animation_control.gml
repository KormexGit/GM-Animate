/// feather ignore all

/// @desc Plays an animation. Must be called at least once on an object before using any other animation functions.
/// Creates a new animation struct, so if the specified track already has an animation playing then
/// effects, the animation queue, and variable changes will be reset.
/// Use animation_change instead to change the sprite without resetting things.
/// @param {asset.GMSprite} _sprite The sprite asset to animate.
/// @param {Bool} _loop Whether the animation should loop or not upon completion.
/// @param {Real} _track The track to play the animation on.
/// @return {Struct} Animation struct
function animation_start(_sprite, _loop = true, _track = 0) {
	animations[_track] = new __animation(_sprite, _loop);
	return animations[_track];
}

/// @desc Runs the animations for this object. Must be called in a step event for animations to work.
function animation_run() {
		
	__animation_array_error();
		
	for(var i = 0, _len = array_length(animations); i < _len; i++;) { 
		if animations[i] == 0 {
			continue;	
		}
		animations[i].__animate();
	}
}


/// @desc Change an animation track to a different sprite without resetting effects, the animation queue, or variables.
/// The equivalent of changing sprite_index when using GameMaker's built in animation.
/// @param {asset.GMSprite} _sprite The sprite asset to animate.
/// @param {Real} _starting_image_index The frame to start the new animation on. Pass -1 to not change image_index and keep the frame of the previous animation.
/// @param {Bool} _loop Whether the animation should loop or not upon completion.
/// @param {Real} _track The track to change the animation on.
/// @return {Struct} Animation struct
function animation_change(_sprite, _starting_image_index = 0, _loop = true, _track = 0) {
	__animation_error_checks

	with animations[_track] {
		if sprite_index != _sprite {
			if loop == false and image_speed == 0 {
				image_speed = 1;
			}
			sprite_index = _sprite;
			sprite_name = sprite_get_name(sprite_index);
			if _starting_image_index != -1 {
				image_index = _starting_image_index;
			}
			loop = _loop;
			__animation_variable_setup();
		}
	}
	return animations[_track];
}

/// @desc Draw an animation. Must be called for an animation to appear. Should always be called in a draw related event.
/// @param {Real} _x x coordinate to draw at. Defaults to the instance's x.
/// @param {Real} _y y coordinate to draw at. Defaults to the instance's y.
/// @param {Real} _track The track to draw. Pass `all` to draw every active track.
function animation_draw(_x = x, _y = y, _track = 0) {
	__animation_error_checks
	
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
			if animations[i] == 0 {
				continue;
			}
			animations[i].__draw(_x, _y);
		}
		return;
	}		
	animations[_track].__draw(_x, _y);
}

/// @desc Draw an animation with different parameters than it's current variables, similar to draw_sprite_ext. Should always be called in a draw related event.
/// All arguments are optional, and default to the animation's value for that variable. 
/// @param {Real} _x x coordinate to draw at. Defaults to the instance's x.
/// @param {Real} _y y coordinate to draw at. Defaults to the instance's y.
/// @param {Real} _image_index The frame to draw.
/// @param {Real} _image_xscale The base xscale to use. Effects that change xscale will apply their multiplier to this value.
/// @param {Real} _image_yscale The base yscale to use. Effects that change yscale will apply their multiplier to this value.
/// @param {Real} _image_angle The angle to draw at. Effects that change angle will be relative to this value.
/// @param {Real} _image_blend The blend to draw with.
/// @param {Real} _image_alpha The alpha to draw at.
/// @param {Real} _track The track to draw. Pass `all` to draw every active track.
function animation_draw_ext(_x = undefined, _y = undefined, _image_index = undefined, _image_xscale = undefined, _image_yscale = undefined,
	_image_angle = undefined, _image_blend = undefined, _image_alpha = undefined, _track = 0) {
		
	__animation_error_checks
	
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
			if animations[i] == 0 {
				continue;
			}
			animations[i].__draw_ext(_image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _image_blend, _image_alpha);
		}
		return;
	}	
	
	animations[_track].__draw_ext(_image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _image_blend, _image_alpha);
}

/// @desc Set the instance's collision mask to match the specified animation track. Effects (such as shake, squash and stretch) will not affect the mask's position or size.
/// WARNING: This function changes the calling instance's mask_index and image_index, so it will interfere with built in animation.
/// Additionally, it will change the calling instance's image_xscale, image_yscale, and/or image_angle if _use_scale and/or _use_angle are set to true. 
/// @param {Bool} _use_scale Whether to match the instance's image_xscale and image_yscale to the animation's image_xscale and image_yscale. 
/// @param {Bool} _use_angle Whether to match the instance's image_angle to the animation's image_angle. 
/// @param {Real} _track The track to get the sprite from to use as the collision mask.
function animation_set_instance_mask(_use_scale = false, _use_angle = false, _track = 0) {
	__animation_error_checks
	
	var _anim = animations[_track];
	mask_index = _anim.sprite_index;
	image_index = _anim.image_index;
	if _use_scale == true {
		image_xscale = _anim.image_xscale;
		image_yscale = _anim.image_yscale;
	}
	if _use_angle == true {
		image_angle = _anim.image_angle;	
	}
}

/// @desc Returns the animation struct for the specified track.
/// @param {Real} _track The track to get. Pass `all` to get an array of all animation structs. 
/// @return {Array<Struct>|Struct} Animation struct or array of animation structs
function animation_get(_track = 0) {
	__animation_error_checks
	if _track == all {
		return animations;
	}
	return animations[_track];	
}

/// @desc Checks whether an animation exists on the specified track.
/// @param {Real} _track The track to check.
/// @return {Bool} Whether the animation exists or not
function animation_exists(_track = 0) {
	if !variable_instance_exists(id, "animations") { 
		return false;
	}
	if array_length(animations) <= _track or animations[_track] == 0 {
		return false;	
	}
	if instanceof(animations[_track]) == "__animation" {
		return true;	
	}
	return false;
}

/// @desc Removes the specified animation track, deleting it entirely.
/// @param {Real} _track The track to delete. Pass `all` to remove all animations from every track.
function animation_delete(_track) {
	__animation_error_checks
	
	if _track == all {
		array_resize(animations, 0);
		return;
	}
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

/// @desc Checks if an animation reached the end of it's last frame this step.
/// @param {Real} _track The track to check.
/// @return {Bool} Whether the animation finished this step or not
function animation_finished(_track = 0) {
	__animation_error_checks
	
	return animations[_track].finished;
}

/// @desc Checks if an animation is currently on the specified frame. Can return true multiple steps in a row.
/// @param {Real|Array<Real>} _frame The frame to check, or an array of frames to check.
/// @param {Real} _track The track to check.
/// @return {Bool} Whether the animation is on the specified frame or not
function animation_on_frame(_frame, _track = 0) {
	__animation_error_checks
	
	if is_array(_frame) {
		for (var i = 0, _len = array_length(_frame); i < _len; ++i) {
			if floor(animations[_track].image_index) == floor(_frame[i]) {
				return true;	
			}
		}
	}
	else if floor(animations[_track].image_index) == floor(_frame) {
		return true;	
	}
}

/// @desc Checks if an animation arrived at the specified frame this step. Will only return true the first step the animation is on that frame.
/// @param {Real|Array<Real>} _frame The frame to check, or an array of frames to check.
/// @param {Real} _track The track to check.
/// @return {Bool} Whether the animation arrived at the specified frame this step or not.
function animation_enter_frame(_frame, _track = 0) {
	__animation_error_checks
	
	if is_array(_frame) {
		for (var i = 0, _len = array_length(_frame); i < _len; ++i) {
			if animations[_track].new_frame == floor(_frame[i]) {
				return true;	
			}
		}
	}
	else if animations[_track].new_frame == floor(_frame) {
		return true;	
	}
}

/// @desc Sets a variable for the specified track. Can be used to set a variable for all tracks at once.
/// Intended use is with built in variables, such as "image_angle", "image_xscale", etc.
/// @param {String} _variable_name The variable to change, as a string. 
/// @param {Any} _value The value to set the variable to.
/// @param {Real} _track The track to set. Pass `all` to set all tracks at once.
function animation_set_variable(_variable_name, _value, _track = 0) {
	__animation_error_checks
	
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
		    if animations[i] == 0 {
				continue;
			}
			animations[i][$ _variable_name] = _value;
		}
		return;
	}
	animations[_track][$ _variable_name] = _value;
}

/// @desc Sets looping for the animation on the specified track. 
/// @param {Bool} _loop Whether to loop or stop looping.
/// @param {Real} _track The track to set. Pass `all` to set all tracks at once.
function animation_set_looping(_loop, _track = 0) {
	__animation_error_checks
	if _track == all {
		for (var i = 0, _len = array_length(animations); i < _len; ++i) {
			if animations[i] == 0 {
				continue;
			}
			animations[i].loop = _pause;	
		}
		return;
	}
	animations[_track].loop = _loop;
}

/// @desc Checks if the specified track is looping or not.
/// @param {Real} _track The track to check.
/// @return {Bool} Whether the specified track is currently looping or not.
function animation_get_looping(_track = 0) {
	__animation_error_checks
	
	return animations[_track].loop;
}

/// @desc Returns the width of the animation, image_xscale factored in. Equivalent to GM's built in sprite_width.
/// @param {Real} _track The track to get the width of.
function animation_get_sprite_width(_track = 0) {
	__animation_error_checks
	
	var _anim = animations[_track];
	return sprite_get_width(_anim.sprite_index)*abs(_anim.image_xscale);
}

/// @desc Returns the height of the animation, image_yscale factored in. Equivalent to GM's built in sprite_height.
/// @param {Real} _track The track to get the height of.
function animation_get_sprite_height(_track = 0) {
	__animation_error_checks
	
	var _anim = animations[_track];
	return sprite_get_height(_anim.sprite_index)*abs(_anim.image_yscale);
}