mouse_x_gui = device_mouse_x_to_gui(0);
mouse_y_gui = device_mouse_y_to_gui(0);

var array = file_dropper_get_files();
file_dropper_flush();

if (array_length(array) > 0) {
	for (var i = 0, len = array_length(array); i < len; ++i) {
		var filePath = array[i];
		var fileString = filePath + "\\*.png";
		var file_name = file_find_first(fileString, fa_none);

		var spriteToAdd;
		while (file_name != "")
		{
			var spritePath = filePath + "\\" + file_name;
		    spriteToAdd = sprite_add(spritePath, 1, false, false, 0, 0);
			array_push(imagesForEditing, sprite);
			
		    file_name = file_find_next();
		}
		//fileString = array[i] + "\\*.yy";
		//file_name = file_find_first(fileString, fa_none);

		//while (file_name != "")
		//{
		//    file_name = file_find_next();
		//}

		file_find_close(); 
	}
}

if mouse_wheel_up() {
	zoom += zoomSpd;
}
if mouse_wheel_down() {
	zoom -= zoomSpd;
}
zoom = clamp(zoom, 1, 1000);

if array_length(imagesForEditing) > 0 {
	if keyboard_check_pressed(vk_right) {
		arrayPos = min(arrayPos + 1, array_length(imagesForEditing) - 1);
		set_zoom();
	}
	if keyboard_check_pressed(vk_left) {
		arrayPos = max(arrayPos - 1, 0);	
		set_zoom();
	}

	sprite = imagesForEditing[arrayPos];
	w = sprite_get_width(sprite)*zoom;
	h = sprite_get_height(sprite)*zoom;
	var offsetX = pixel_snap(w/2);
	var offsetY = pixel_snap(h/2);
	spriteX = pixel_snap(x) - offsetX;
	spriteY = pixel_snap(y) - offsetY;
}

if mouse_check_button(mb_left) {
	point.x = pixel_snap(mouse_x_gui);
	point.y = pixel_snap(mouse_y_gui);
	point.update();
}

//if mouse_check_button(mb_middle) and (mouse_x_gui != prev_mouse_x or mouse_y_gui != prev_mouse_y) {
//	var diffX = mouse_x_gui - prev_mouse_x;
//	var diffY = mouse_y_gui - prev_mouse_y;
//	x += diffX;
//	y += diffY;
//	//point.x = mouse_x_gui - (mouse_x_gui mod zoom);
//	//point.y = mouse_y_gui - (mouse_y_gui mod zoom);
//}