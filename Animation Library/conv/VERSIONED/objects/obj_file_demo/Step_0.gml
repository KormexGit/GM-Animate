var array = file_dropper_get_files();
file_dropper_flush();

if (array_length(array) > 0) {
    self.files = array;
}

debug(files);