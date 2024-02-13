//feather ignore all
hor_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
key_jump = keyboard_check_pressed(vk_space);
key_attack = mouse_check_button_pressed(mb_left);
key_run = keyboard_check(vk_shift);

state.step();

if hsp != 0 {
	anim.image_xscale = sign(hsp);
}

if keyboard_check_pressed(vk_up) {
	animation_effect_squash_and_strech(30, 0.5, animation_curve_one_way_middle);
} 

if keyboard_check_pressed(vk_left) {
	animation_effect_squash_and_strech(30, 0.5, animation_curve_one_way_start);
}

if keyboard_check_pressed(vk_right) {
	animation_effect_squash_and_strech(30, 0.5, animation_curve_one_way_end);
}

if keyboard_check_pressed(vk_down) {
	animation_effect_hitstop(12);
}

