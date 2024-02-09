function create_state() constructor {
	enter = function() {};
	step = function() {};
	finish = function() {};
}

function change_state(_new_state) {
	state.finish();
	state = _new_state;
	state.enter();
}