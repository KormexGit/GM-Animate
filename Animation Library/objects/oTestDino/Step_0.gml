if keyboard_check_pressed(vk_space) {
	animation_shake(30, 20);
	animation_hitstop(50);
}

if keyboard_check_pressed(vk_up) {
	animation_remove(1);
}

if keyboard_check_pressed(vk_down) {
	animation_set_pause_all(!animation_get_pause_all());
}

if keyboard_check_pressed(vk_left) {
	animation_get(50);
}