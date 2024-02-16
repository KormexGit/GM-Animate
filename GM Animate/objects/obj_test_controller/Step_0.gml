///feather ignore all
with obj_player {
	if keyboard_check_pressed(vk_up) {
		animation_effect_oscillate(90, 30, 90, true);
	} 

	if keyboard_check_pressed(vk_left) {
		animation_effect_squash_and_strech(30, 0.5);
	}

	if keyboard_check_pressed(vk_right) {
		animation_effect_oscillate(120, 20, 145, true, animation_curve_snap_middle);
	}

	if keyboard_check_pressed(vk_down) {
		animation_effect_sway(30, 45, 0, 120);
	}	
}

if keyboard_check_pressed(vk_tab) {
	if player_active {
		instance_deactivate_object(obj_player);
		player_active = false;
	}
	else {
		instance_activate_object(obj_player);
		player_active = true;
	}
}	