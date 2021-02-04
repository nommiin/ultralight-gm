// Call ultralight_render to call the render method of the renderer
ultralight_render();

// Render our primary view at (8, 8)
ultralight_view_render(view_main, 8, 8);

// Render our secondary view at (480, 32) and make it move a bit
ultralight_view_render(view_second, 480 + (sin(current_time / 400) * 32), 32);

// Some debug information
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(window_get_width() - 4, 4, "Mouse: (" + string(window_mouse_get_x()) + ", " + string(window_mouse_get_y()) + ")\nFPS: " + string(fps) + " (" + string(fps_real) + ")");