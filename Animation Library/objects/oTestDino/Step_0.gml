if keyboard_check_pressed(vk_space) {
	animation_shake(30, 20);
}

if keyboard_check_pressed(vk_up) {
	animation_squash_and_strech(30, 10)
}

if animation_finished() {
	debug("finished!");	
}

if animation_arrived_at_frame(1) {
	debug("on frame 1!");	
}