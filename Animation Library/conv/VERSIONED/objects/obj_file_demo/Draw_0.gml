draw_set_font(FDefault);

if (array_length(files) > 0) {
    for (var i = 0; i < array_length(self.files); i++) {
        draw_text(64, 64 + 48 * i, self.files[i]);
    }
} else {
    draw_text(64, 64, "Drag some files into the window from Explorer!");
}