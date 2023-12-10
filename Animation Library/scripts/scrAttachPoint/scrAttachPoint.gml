function point_data() constructor {
	x = 0;
	y = 0;
	direction = 0;
	outputX = 0;
	outputY = 0;
	update = function() {
		outputX = (x - other.spriteX) div other.zoom;
		outputY = (y - other.spriteY) div other.zoom;
	}
	zoomReset = function() {
		x = (outputX * other.zoom) + other.spriteX;
		y = (outputY * other.zoom) + other.spriteY;
	}
	getClicked = function() {
		var zoom = other.zoom;
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x - 4*zoom, y - 4*zoom, x + 5*zoom, y + 5*zoom) and mouse_check_button_pressed(mb_left) {
			return true;	
		}
	}
	getRightClicked = function() {
		var zoom = other.zoom * 10;
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x - zoom, y - zoom, x + zoom, y + zoom) and mouse_check_button_pressed(mb_right) {
			return true;	
		}
	}
}

function sprite_data(_sprite) constructor {
	sprite_index = _sprite;
	points = [];
}

function point_add() {
	if array_length(images) == 0 {
		show_message("No image loaded");
		return false;
	}
	array_push(images[arrayPos].points, new point_data());
}

function pixel_snap(num) {
	return num - (num mod oAttachPointSetter.zoom);
}