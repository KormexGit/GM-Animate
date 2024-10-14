function __curve_runner(_curve, _channel, _variable_name, _start_value, _end_value, _duration, _loops = 1, _owner = id) constructor {
	curve = _curve;
	variable = _variable_name;
	start_value = _start_value;
	end_value = _end_value;
	duration = _duration;
	loop_count = _loops;
	owner = _owner;
	
	calling_instance = other.id;
	
	curve_progress = 0;
	rate = 1/duration;
	channel = animcurve_get_channel(curve, _channel);
	
	static __curve_get_index = function() {
		var _array = calling_instance.curves;
		for (var i = 0, _len = array_length(_array); i < _len; ++i) {
		    if _array[i] == self {
				return i;
			}
		}
	}
	
	static __curve_process = function() {
		curve_progress += rate;
		
		if curve_progress > 1 {
			if loop_count <= 1 {
				var _index = __curve_get_index();
				array_delete(calling_instance.curves, _index, 1);
				return;
			}
			else {
				curve_progress = 0;	
				loop_count -= 1;
			}
		}	
		
		var _prog = animcurve_channel_evaluate(channel, curve_progress);
		
		owner[$ variable] = lerp(start_value, end_value, _prog);
	}
	
	//static __curve_automatic = function() {
	//	var ts = time_source_create(time_source_game, 1, time_source_units_frames, function() {
	//		curve_progress += rate;
		
	//		if curve_progress > 1 {
	//			if loop_count <= 1 {
	//				var _index = __curve_get_index();
	//				array_delete(calling_instance.curves, _index, 1);
	//				return;
	//			}
	//			else {
	//				curve_progress = 0;	
	//				loop_count -= 1;
	//			}
	//		}	
		
	//		var _prog = animcurve_channel_evaluate(channel, curve_progress);
		
	//		owner[$ variable] = lerp(start_value, end_value, _prog);
	//	})
	//	array_push(calling_instance.curves, ts);
	//}
}