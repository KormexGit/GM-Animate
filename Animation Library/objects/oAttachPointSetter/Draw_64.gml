var len = array_length(imagesForEditing);
if len > 0 {
	//for (var i = 0; i < len; ++i) {
	//	var sprite = imagesForEditing[i]
	//    draw_sprite(sprite, 0, arrayPos, 50);
	//	arrayPos += sprite_get_width(sprite)
	//}
	draw_sprite_ext(sprite, 0, spriteX, spriteY, zoom, zoom, 0, c_white, 1);
	draw_sprite_stretched(sAreaBox, 0, spriteX, spriteY, w, h);
}

draw_sprite_ext(sPoint, 0, point.x, point.y, zoom, zoom, 0, c_white, 1);

draw_text(50, 50, point.outputX);
draw_text(50, 100, point.outputY);