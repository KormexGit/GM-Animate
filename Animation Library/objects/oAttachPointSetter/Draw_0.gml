//draw_set_font(FDefault);

//if (array_length(files) > 0) {
//    for (var i = 0; i < array_length(self.files); i++) {
//        draw_text(64, 64 + 48 * i, self.files[i]);
//    }
//}

var pos = 0;
for (var i = 0, len = array_length(imagesForEditing); i < len; ++i) {
	var sprite = imagesForEditing[i]
    draw_sprite(sprite, 0, pos, 50);
	pos += sprite_get_width(sprite)
}