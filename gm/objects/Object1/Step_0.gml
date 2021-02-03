ultralight_update(window_mouse_get_x(), window_mouse_get_y());

if (keyboard_check_pressed(ord("7")) == true) {
	show_message(ultralight_view_eval(test.view, @'document.getElementsByTagName("h1")[0].innerText'));
}


