#macro _animation_array_error \
if !variable_instance_exists(id, "animations") { \
	show_debug_message("Warning! Tried to use an animation function on an object that did not call animation_init: " + object_get_name(object_index)); \
	return; \
} \