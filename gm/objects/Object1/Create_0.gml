test = ultralight_view_create(320, 240, false);
ultralight_view_load(test.view, @'<body><h1>Hello!</h1><input id="in"><button type="button" onclick="FromJS()">Callback Button</button></body>', false);
ultralight_view_focus(test, true);
ultralight_view_bind(test, "FromJS", function() {
	show_message("You Entered: " + ultralight_view_eval(view, "document.getElementById('in').value"));
});

test2 = ultralight_view_create(640, 640, false);
ultralight_view_load(test2.view, @'https://codepen.io/jaysalvat/pen/HaqBf', true);
