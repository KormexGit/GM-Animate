if keyboard_check_pressed(vk_space) {
	animation_shake(120, 20, all);
	animation_hitstop(50);
}

if keyboard_check_pressed(vk_up) {
	animation_squash_and_strech(60, 10);
}

if keyboard_check_pressed(vk_down) {
	animation_set_pause_all(false);
}

if keyboard_check_pressed(vk_left) {
	animation_get(50);
}