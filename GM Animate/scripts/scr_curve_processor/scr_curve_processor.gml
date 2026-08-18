//feather ignore all

/// @desc Changes a variable from one value to another, following an animation curve.
/// @param {Asset.GMAnimCurve} _curve The animation curve asset to use.
/// @param {Real} _channel The channel to use.
/// @param {String} _variable_name The name of the variable to change, as a string.
/// @param {Real} _start_value The starting value of the variable.
/// @param {Real} _start_value The ending value of the variable (what it will be when the curve ends).
/// @param {Real} _duration How long it should take for the value to change.
/// @param {Real} _loops How many times the curve should repeat. Pass `infinity` to repeat forever. Defaults to 1.
/// @param {Id.Instance|Struct} _owner The instance (or struct) that owns the variable. Set to the calling instance by default.
function curve_lerp(_curve, _channel, _variable_name, _start_value, _end_value, _duration, _loops = 1, _owner = id) {
	var curve = new __curve_runner_lerp(_curve, _channel, _variable_name, _start_value, _end_value, _duration, _loops, _owner);
	array_push(curves, curve);
	return curve;
}

function curve_wave(_curve, _channel, _variable_name, _range, _duration, _loops = 1, _owner = id) {
	var curve = new __curve_runner_wave(_curve, _channel, _variable_name, _range, _duration, _loops, _owner);
	array_push(curves, curve);
	return curve;
}

/// @desc Runs any active curves on this instance. Must be called in step for the curves to work.
function curve_run() {
	for(var i = array_length(curves) - 1; i > -1; i--) {
		curves[i].__curve_process();
	}
}

function curve_init() {
	curves = [];	
}

function curve_is_finished(_curve) {
	if _curve.curve_progress >= 1 {
		return true;
	}
	return false;
}

function curve_force_finish(_curve) {
	_curve.curve_progess = 1;
	_curve.loop_count = 0;
}