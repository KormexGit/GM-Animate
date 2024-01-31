if keyboard_check_pressed(vk_space) {
	animation_shake(30, 20);
}

if keyboard_check_pressed(vk_up) {
	animation_squash_and_strech(30, 10)
}

if keyboard_check_pressed(vk_down) {
	animation_queue_add(sJump);
	animation_queue_add(sWalk);
}

if keyboard_check_pressed(vk_down) {
	animation_queue_add(sJump);
	animation_queue_add(sWalk);
	animation_queue_add(sDodge);
		animation_queue_add(sDodge);
			animation_queue_add(sDodge);
				animation_queue_add(sDodge);
					animation_queue_add(sDodge);
	animation_queue_add(sIdle);
}

if keyboard_check_pressed(vk_left) {
	animation_queue_remove_sprite(sDodge)
}