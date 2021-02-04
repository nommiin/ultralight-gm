// Create a 320x480 non-transparent view
view_main = ultralight_view_create(320, 480, false);

// Lame workaround for string literals
var _el = @'"input_main"';

// Load some test HTML onto the page
ultralight_view_load(view_main.view, @"
	<html>
		<head>
			<style>
				h1 {
					color: blue;
				}
				
				p {
					border-left: 4px solid gray;
					padding-left: 8px;
				}
				
				#small {
					padding: 0;
					font-size: 12px;
				}
			</style>
		</head>
		<body>
			<h1>Hello from Ultralight-GM!</h1>
			<input type='text' id='input_main'>
			<button type='button' onclick='Callback_GM(1, 2959021, document.getElementById(" + _el + @").value)'>Test Callback!</button>
			<hr>
			<div id='small'>Click the bunny for a surprise!</div>
			<img src='https://i.imgur.com/nEQFdD0.png' onclick='PetBunny()'>
			<p>
				Wow, that is such a cute bunny! How are they gonna eat all of that corn?!
			</p>
		</body>
	</html>
", false);

// Bind a GML function to the Callback_GM function
ultralight_view_bind(view_main, "Callback_GM", function( a, b, c ) {
	// Print out arguments and check types
	show_debug_message("Expected Value: 1 (real) - Recieved Value: " + string(a) + " (" + typeof(a) + ")");
	show_debug_message("Expected Value: 2959021 (real) - Recieved Value: " + string(b) + " (" + typeof(b) + ")");
	show_debug_message("Expected Value: " + ultralight_view_eval(self.view, "document.getElementById('input_main').value") + " (string) - Recieved Value: " + string(c) + " (" + typeof(c) + ")");
	
	// Show a message containing the textbox value as provided in argument 3
	show_message("You Entered: " + c);
});

// Bind another GML function to the PetBunny function
ultralight_view_bind(view_main, "PetBunny", function() {
	instance_create_depth(mouse_x, mouse_y, -1, objPet);
});

// Let's also make an example web page (literally)
view_second = ultralight_view_create(640, 720, true);
ultralight_view_load(view_second.view, "https://example.com/", true);