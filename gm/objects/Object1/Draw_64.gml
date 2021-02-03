ultralight_render();

ultralight_view_render(test, 16, 32);
ultralight_view_render(test2, 480, 72);

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text(window_get_width() - 4, 4, "Mouse: (" + string(window_mouse_get_x()) + ", " + string(window_mouse_get_y()) + ")\nFPS: " + string(fps) + " (" + string(fps_real) + ")");
/*

if (ultralight_view_copy(view, buffer_get_address(buffer)) == 1) {
	buffer_set_surface(buffer, surface, 0);
	show_debug_message("copied buffer");
}

draw_surface(surface, 32, 32);*/