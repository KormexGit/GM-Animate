if keyboard_check_pressed(vk_space) {
	animation_shake(30, 20);
	animation_hitstop(50);
}

if keyboard_check_pressed(vk_up) {
	animation_set_pause_all(true);
}

if keyboard_check_pressed(vk_down) {
	animation_set_pause_all(false);
}

if keyboard_check_pressed(vk_left) {
	animation_get(50);
}