function JSON_buffer_save(data, filename) {
	var saveString = json_stringify(data);
	debug(json_parse(saveString));
	var saveBuffer = buffer_create(string_byte_length(saveString) + 1, buffer_fixed, 1);
	buffer_write(saveBuffer, buffer_string, saveString);
	buffer_save(saveBuffer, filename);
	buffer_delete(saveBuffer);
}

function JSON_buffer_load(filename) {
	if !file_exists(filename) {
		return;
	}
	var loadBuffer = buffer_load(filename);
	var loadString = buffer_read(loadBuffer, buffer_string);
	buffer_delete(loadBuffer);
	return json_parse(loadString);
}