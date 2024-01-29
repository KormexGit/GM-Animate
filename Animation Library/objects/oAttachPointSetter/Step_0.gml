mouse_x_gui = device_mouse_x_to_gui(0);
mouse_y_gui = device_mouse_y_to_gui(0);

var array = file_dropper_get_files();
file_dropper_flush();

if (array_length(array) > 0) {
	for (var i = 0, len = array_length(array); i < len; ++i) {
		var filePath = array[i];
		var fileString = filePath + "\\*.png";
		var file_name = file_find_first(fileString, fa_none);

		while (file_name != "")
		{
			var spritePath = filePath + "\\" + file_name;
		    var spriteToAdd = sprite_add(spritePath, 1, false, false, 0, 0);
			array_push(images, new sprite_data(spriteToAdd));
			
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


if array_length(images) > 0 {
	if mouse_wheel_up() {
		zoom += zoomSpd;
	}
	if mouse_wheel_down() {
		zoom -= zoomSpd;
	}
	
	if keyboard_check_pressed(vk_right) {
		arrayPos = min(arrayPos + 1, array_length(images) - 1);
		set_zoom();
	}
	if keyboard_check_pressed(vk_left) {
		arrayPos = max(arrayPos - 1, 0);	
		set_zoom();
	}
	zoom = max(1, zoom);
	
	sprite = images[arrayPos].sprite_index;
	w = sprite_get_width(sprite)*zoom;
	h = sprite_get_height(sprite)*zoom;
	var offsetX = pixel_snap(w/2);
	var offsetY = pixel_snap(h/2);
	spriteX = pixel_snap(x) - offsetX;
	spriteY = pixel_snap(y) - offsetY;
	
	if mouse_wheel_up() {
		set_point_zoom();
	}
	if mouse_wheel_down() {
		set_point_zoom();
	}
	
}

if pointBeingMoved == undefined {
	for (var i = 0, len = array_length(images[arrayPos].points); i < len; ++i) {
	    if images[arrayPos].points[i].getClicked() {
			pointBeingMoved = images[arrayPos].points[i];
			break;
		}
	}
}
else {
	pointBeingMoved.x = pixel_snap(mouse_x_gui);
	pointBeingMoved.y = pixel_snap(mouse_y_gui);
	pointBeingMoved.update();
}

if pointBeingRotated == undefined {
	for (var i = 0, len = array_length(images[arrayPos].points); i < len; ++i) {
	    if images[arrayPos].points[i].getRightClicked() {
			pointBeingRotated = images[arrayPos].points[i];
			break;
		}
	}
}
else {
	with pointBeingRotated {
		direction = point_direction(x, y, other.mouse_x_gui, other.mouse_y_gui);
	}
}

if mouse_check_button_released(mb_left) { 
	pointBeingMoved = undefined;	
}

if mouse_check_button_released(mb_right) { 
	pointBeingRotated = undefined;	
}


if keyboard_check_pressed(vk_space) {
	point_add();
}

if keyboard_check_pressed(vk_escape) {
	array = [];	 
	for (var i = 0, len = array_length(images[arrayPos].points); i < len; ++i) {
		var point = images[arrayPos].points[i];
		var struct = {
			x : point.outputX,
			y : point.outputY,
			direction : point.direction
		}
		array_push(array, struct);

	}
	debug("saved");
	JSON_buffer_save(array, "Test");
}

//if mouse_check_button(mb_left) {
//	point.x = pixel_snap(mouse_x_gui);
//	point.y = pixel_snap(mouse_y_gui);
//	point.update();
//}

if mouse_check_button(mb_middle) and (mouse_x_gui != prev_mouse_x or mouse_y_gui != prev_mouse_y) {
	diffX += mouse_x_gui - prev_mouse_x;
	diffY += mouse_y_gui - prev_mouse_y;
	var _x = x;
	var _y = y;
	var snapX = pixel_snap(diffX);
	var snapY = pixel_snap(diffY);
	x += snapX;
	y += snapY;	
	set_point_pos(snapX, snapY);
	if _x != x or _y != y {
		diffX -= snapX;
		diffY -= snapY;
	}
}