#macro _animation_array_setup if !variable_instance_exists(id, "_animationsArray") {_animationsArray = [];}

#macro _animation_array_error if !variable_instance_exists(id, "_animationsArray") { show_debug_message("Warning! Tried to use an animation function when no animation was set for object " + object_get_name(object_index)); return;}