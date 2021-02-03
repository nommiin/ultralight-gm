test = ultralight_view_create(320, 240, false);
ultralight_view_load(test.view, @'<body><h1>Hello!</h1><input type="text"></body>', false);
ultralight_view_focus(test, true);

test2 = ultralight_view_create(640, 640, false);
ultralight_view_load(test2.view, @'<h1>hey</h1>', false);