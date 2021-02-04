draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(a);
for(var i = 0; i <= 360; i += 360 / 8) {
	draw_set_color(c_black);
	draw_text(x + lengthdir_x(1, i), y + lengthdir_y(1, i), "PET!");
}
draw_set_colour(make_colour_hsv(c, 128, 255));
draw_text(x, y, "PET!");
draw_set_alpha(1);
draw_set_alpha(c_white);

y -= 1;
if (t-- <= 0) {
	a -= 0.1;
	if (a <= 0) {
		instance_destroy();	
	}
}