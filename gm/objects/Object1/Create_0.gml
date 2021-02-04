test = ultralight_view_create(1280, 720, true);
var buff = buffer_load("test.html"), page = buffer_read(buff, buffer_text);
buffer_delete(buff);
ultralight_view_load(test, page, false);

ultralight_view_bind(test, "FromJS", function( _val ) {
	show_message("You Entered: " + _val);
});