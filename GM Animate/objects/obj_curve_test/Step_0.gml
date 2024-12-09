//curve_run();

if keyboard_check_pressed(vk_space) {
	curve_start(animation_curve_wave, "x", "x", x, x + 100, 30, 1, struct);

}
x = struct.x;