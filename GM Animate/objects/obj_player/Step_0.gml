//feather ignore all

animation_run();


hor_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
key_jump = keyboard_check_pressed(vk_space);
key_attack = mouse_check_button_pressed(mb_left);
key_run = keyboard_check(vk_shift);

state.step();

if hsp != 0 {
	anim.image_xscale = sign(hsp);
}