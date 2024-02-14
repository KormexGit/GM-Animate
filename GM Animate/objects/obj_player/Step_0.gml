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
	animation_effect_oscillate(90, 30, 90, true);
} 

if keyboard_check_pressed(vk_left) {
	animation_effect_squash_and_strech(30, 0.5, true, animation_curve_one_way_middle);
}

if keyboard_check_pressed(vk_right) {
	animation_effect_oscillate(120, 20, 145, true, animation_curve_snap_middle);
}

if keyboard_check_pressed(vk_down) {
	animation_effect_sway(30, 45, 0, 120, true);
}