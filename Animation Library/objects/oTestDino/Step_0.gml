if keyboard_check_pressed(vk_space) {
	animation_shake(120, 20, all);
	animation_hitstop(50);
}

if keyboard_check_pressed(vk_up) {
	animation_squash_and_strech(60, 8);
}