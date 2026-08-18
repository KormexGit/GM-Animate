//GM Animate version: 1.0

///feather ignore all

/// @desc The core animation constructor. Contains the variables and methods needed to animate, run events, draw, etc.
/// @param {any*} _sprite The sprite to create the animation for.
/// @param {bool} [_loop] Whether to loop or not by default.
function __animation(_sprite, _loop = true) constructor {
	if instance_exists(other) {
		creator = other.id;	
	}
	else {
		show_error("GM Animate: tried to use animation_start in a non-instance scope. \nGM Animate currently only supports being run on instances, not structs or other scopes.", true);	
	}
	
	//This function calculates how much should be added to image_index each frame based on FPS settings on the sprite.
	static __animation_get_speed = function(_sprite = sprite_index) {
		//TY Tabularelf for the base of this function! I converted it from a ternary to an if/else cuz I can't read ternaries to save my life
		var _sprite_speed;
		if sprite_get_speed_type(_sprite) == spritespeed_framespergameframe {
			_sprite_speed = sprite_get_speed(_sprite);
		}
		else {
			_sprite_speed = sprite_get_speed(_sprite)/game_get_speed(gamespeed_fps);
		}
		return _sprite_speed;
	}
	
	//Sets variables that need to update when the sprite is changed via animation_change.
	//This is why animation_change is needed instead of changing sprite_index directly.
	static __animation_variable_setup = function() {
		image_number = sprite_get_number(sprite_index);
		sprite_speed = __animation_get_speed(sprite_index);
		frame_timing_array = sprite_get_info(sprite_index).frame_info;
	}
	
	//Basic variables
	sprite_index = _sprite;
	sprite_name = sprite_get_name(sprite_index);
	__animation_variable_setup();
	image_index = 0;
	image_speed = 1;
	image_xscale = 1;
	image_yscale = 1;
	image_angle = 0;
	image_blend = c_white;
	image_alpha = 1;
	loop = _loop;
	paused = false;
	effect_pause = false;
	
	finished = false;
	new_frame = -1;
	
	//Resets the offset variables that are used by effects.
	static __reset_effect_offsets = function() {
		x_offset = 0;
		y_offset = 0;
		xscale_offset = 0;
		yscale_offset = 0;
		angle_offset = 0;
		alpha_offset = 0;
	}
	
	__reset_effect_offsets();
	
	effects = [];
	queue = [];
	events = {};
	
	//The main animate function. This increments image_index, figures out if the animation is finished, handles events and the queue.
	static __animate = function() {
		//Reseting finished and new_frame happens unconditionally to gurantee animation_finished and animation_enter_frame
		//don't incorrectly return true for multiple frames if the animation gets paused.
		finished = false;
		new_frame = -1;
		if paused == true {
			return;
		}
		if image_speed != 0 and effect_pause == false {
			var _previous_frame = floor(image_index);
			var _stretched_frame_modifier = 1;
			//Support for stretched frames
			if frame_timing_array != undefined {
				_stretched_frame_modifier *= (1 / frame_timing_array[image_index].duration);
			}
			image_index += sprite_speed * _stretched_frame_modifier * image_speed;
			if image_speed > 0 {
				if image_index >= image_number {
					//If the animation has completed, mark it as having finished this frame.
					//For use by animation_finished.
					finished = true;
					//Either loop or stop the animation.
					if loop == true {
						image_index = 0;
					}
					else {
						image_speed = 0;
						image_index = image_number - 1;
					}
				}
			}
			else {
				//Backwards animation handling for negative image_speed.
				if image_index <= 0 {
					finished = true;
					if loop == true {
						image_index = image_number;	
					}
					else {
						image_index = 0;
						image_speed = 0;	
					}
				}
			}
			//Check if the animation reached a new frame this step. For use by animation_enter_frame and the event system.
			var _current_frame = floor(image_index);
			if _current_frame > _previous_frame or finished == true {
				new_frame = _current_frame;
			}
		}
		
		//Process events
		if variable_struct_exists(events, sprite_name) {	
			var current_events = events[$ sprite_name];
			for (var i = array_length(current_events) - 1; i > -1; i--;) {
				var _frame = current_events[i].frames;
				if is_array(_frame) {
					for (var j = 0, _len = array_length(_frame); j < _len; ++j) {
					    if _frame[j] == new_frame {
							current_events[i].callback();
						}
					}
					continue;
				}
				if _frame == new_frame {
					current_events[i].callback();
					continue;
				}
			}
		}
		
		//Reset effect offsets from last frame.
		__reset_effect_offsets();
		//Process effects.
		for (var j = array_length(effects) - 1; j > -1; j--;) {
			effects[j].step();
		}
		
		//If the animation finished and there's something in the queue, swap to the queued sprite.
		if finished and array_length(queue) > 0 {
			var _queue_data = queue[0];
			array_delete(queue, 0, 1);
			sprite_index = _queue_data.sprite_index;
			image_index = 0;
			image_speed = 1;
			loop = _queue_data.loop;
			__animation_variable_setup();
		}
	}
	
	//Draws the animation sprite using the animation's variables + effect offsets.
	static __draw = function(_x = other.x, _y = other.y) {
		draw_sprite_ext(sprite_index, image_index, _x + x_offset, _y + y_offset, image_xscale + (xscale_offset * image_xscale), 
		image_yscale + (yscale_offset * image_yscale), 
		image_angle + angle_offset, image_blend, image_alpha - alpha_offset);
	}
	
	//Draws the animation sprite using the animation's variables by default, but allow overwriting them.
	static __draw_ext = function(_image_index = image_index, _x = other.x, _y = other.y, _image_xscale = image_xscale, _image_yscale = image_yscale,
	_image_angle = image_angle, _image_blend = image_blend, _image_alpha = image_alpha) {
		draw_sprite_ext(sprite_index, _image_index, _x + x_offset, _y + y_offset, _image_xscale + (xscale_offset * _image_xscale), 
		_image_yscale + (yscale_offset * _image_yscale), 
		_image_angle + angle_offset, _image_blend, _image_alpha - alpha_offset);
	}
}

//Error handling functions
function __animation_track_error(_track) {
	if _track != all and (_track > array_length(animations) - 1 or animations[_track] == 0 or _track < 0) {
		show_error("GM Animate: tried to access a track that does not exist on object " + object_get_name(object_index) + ", track " + string(_track) + ". \nMake sure the track is created first with animation_start() before using other functions on it.", true); 
	}
}

function __animation_array_error() {
	if !instance_exists(self) {
		show_error("GM Animate: tried to use an animation function in a non-instance scope. \nRunning animations in struct or global scope is currently not supported.", true);
	}
	if !variable_instance_exists(id, "animations") { 
		show_error("GM Animate: tried to use an animation function on an object that never called animation_start: " + object_get_name(object_index) + "\nCall animation_start() on the object before using other animation functions.", true);
	} 
}


















