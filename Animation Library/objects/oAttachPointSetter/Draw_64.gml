var len = array_length(images);
if len > 0 {
	//for (var i = 0; i < len; ++i) {
	//	var sprite = images[i]
	//    draw_sprite(sprite, 0, arrayPos, 50);
	//	arrayPos += sprite_get_width(sprite)
	//}
	var spriteData = images[arrayPos];
	draw_sprite_ext(spriteData.sprite_index, 0, spriteX, spriteY, zoom, zoom, 0, c_white, 1);
	draw_sprite_stretched(sAreaBox, 0, spriteX, spriteY, w, h);
	
	for (var i = 0, len2 = array_length(spriteData.points); i < len2; ++i) {
		var point = spriteData.points[i];
	   	draw_sprite_ext(sPoint, 0, point.x, point.y, zoom, zoom, 0, c_white, 1);
		draw_sprite_ext(sDirectionArrow, 0, point.x, point.y, zoom, zoom, point.direction, c_white, 1);
		draw_text(50, 50 + i*20, point.outputX);
		draw_text(80, 50 + i*20, point.outputY);
		draw_text(110, 50 + i*20, point.direction);
	}
}

