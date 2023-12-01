files = [];

imagesForEditing = [];


function sprite_cleanup() {
	for (var i = 0, len = array_length(imagesForEditing); i < len; ++i) {
		sprite_delete(imagesForEditing[i]);
	}
}