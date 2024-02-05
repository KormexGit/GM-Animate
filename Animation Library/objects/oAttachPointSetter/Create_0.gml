guiW = display_get_gui_width();
guiH = display_get_gui_height()
x = guiW/2;
y = guiH/2;
mouse_x_gui = device_mouse_x_to_gui(0);
mouse_y_gui = device_mouse_y_to_gui(0);
prev_mouse_x = mouse_x_gui;
prev_mouse_y = mouse_y_gui;

diffX = mouse_x_gui - prev_mouse_x;
diffY = mouse_y_gui - prev_mouse_y;

spriteX = 0;
spriteY = 0;
w = 0;
h = 0;
sprite = -1;

images = [];

pointBeingMoved = undefined;
pointBeingRotated = undefined;

#macro RESW 1280
#macro RESH 760


var spritePath = "C:\\Users\\Intel i9\\Desktop\\HologameSC\\Hologame\\Hologame backup\\sprites\\S0\\d78e01bb-821f-4560-8717-5925dfa733d9.png";
sprite = sprite_add(spritePath, 1, false, false, 0, 0);
array_push(images, new sprite_data(sprite));

spritePath = "C:\\Users\\Intel i9\\Desktop\\HologameSC\\Hologame\\Hologame backup\\sprites\\S1\\eafd28e3-1a40-4226-a183-4c181ac7c1c4.png";
sprite = sprite_add(spritePath, 1, false, false, 0, 0);
array_push(images, new sprite_data(sprite));

arrayPos = 0;

zoom = 1;
zoomSpd = 1;

//point = {
//	x : 0,
//	y : 0,
//	outputX : 0,
//	outputY : 0,
//	update : function() {
//		outputX = (x - other.spriteX) div other.zoom;
//		outputY = (y - other.spriteY) div other.zoom;
//	},
//	zoomReset : function() {
//		x = (outputX * other.zoom) + other.spriteX;
//		y = (outputY * other.zoom) + other.spriteY;
//	}
//}

function set_zoom() {
	if array_length(images) == 0 {
		return false;	
	}
	var sprite = images[arrayPos].sprite_index;
	var w = sprite_get_width(sprite);
	var h = sprite_get_height(sprite);
	w = min(w, RESW);
	h = min(h, RESH);
	zoom = min(RESW/w, RESH/h);	
}

function set_point_zoom() {
	for (var i = 0, len = array_length(images[arrayPos].points); i < len; ++i) {
		images[arrayPos].points[i].zoomReset();
	}
}

function set_point_pos(moveX, moveY) {
	for (var i = 0, len = array_length(images[arrayPos].points); i < len; ++i) {
		images[arrayPos].points[i].x += moveX;
		images[arrayPos].points[i].y += moveY;
	}
}

function sprite_cleanup() {
	for (var i = 0, len = array_length(images); i < len; ++i) {
		sprite_delete(images[i].sprite_index);
	}
}