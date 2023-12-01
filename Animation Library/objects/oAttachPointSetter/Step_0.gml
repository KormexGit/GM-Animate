var array = file_dropper_get_files();
file_dropper_flush();

if (array_length(array) > 0) {
    files = array;
	for (var i = 0, len = array_length(array); i < len; ++i) {
		var filePath = array[i];
		var fileString = filePath + "\\*.png";
		debug(fileString);
		var file_name = file_find_first(fileString, fa_none);

		var sprite;
		while (file_name != "")
		{
			var spritePath = filePath + "\\" + file_name;
			debug(spritePath);
		    sprite = sprite_add(spritePath, 1, false, false, 0, 0);
			debug(sprite);
			array_push(imagesForEditing, sprite);
			
		    file_name = file_find_next();
		}
		//fileString = array[i] + "\\*.yy";
		//debug(fileString);
		//file_name = file_find_first(fileString, fa_none);

		//while (file_name != "")
		//{
		//    file_name = file_find_next();
		//}

		file_find_close(); 
	}
}
