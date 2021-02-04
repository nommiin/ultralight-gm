enum UltralightButton {
	kButton_None = 0,
	kButton_Left,
	kButton_Middle,
	kButton_Right,
};

globalvar __ultralight_views; __ultralight_views = [];
globalvar __ultralight_autofocus; __ultralight_autofocus = true;
globalvar __ultralight_binding; __ultralight_binding = ds_map_create();
globalvar __ultralight_keylist; __ultralight_keylist = [
	vk_tab,
	vk_left,
	vk_right,
	vk_up,
	vk_down,
	vk_pageup,
	vk_pagedown,
	vk_home,
	vk_end,
	vk_insert,
	vk_delete,  
	vk_backspace,
	vk_space,
	vk_enter,
	vk_escape,
	vk_control,
	vk_lcontrol,
	vk_rcontrol,
	ord("C"),
	ord("V"),
	ord("Z"),
];
globalvar __ultralight_keybuffer; __ultralight_keybuffer = buffer_create(array_length(__ultralight_keylist), buffer_fast, 1);
function ultralight_view_create( _width, _height, _transparent, _session ) {
	if (_session != undefined) {
		var _view = {
			offset: [0, 0],
			mouse: [0, 0],
			width: _width,
			height: _height,
			surface: surface_create(_width, _height),
			buffer: buffer_create(_width * _height * 4, buffer_fixed, 1),
			view: __ultralight_view_create(_width, _height, _transparent, _session),
			focus: false
		};
		array_push(__ultralight_views, _view);
		return _view;
	} else {
		var _view = {
			offset: [0, 0],
			mouse: [0, 0],
			width: _width,
			height: _height,
			surface: surface_create(_width, _height),
			buffer: buffer_create(_width * _height * 4, buffer_fixed, 1),
			view: __ultralight_view_create(_width, _height, _transparent, -1),
			focus: false
		};
		array_push(__ultralight_views, _view);
		return _view;
	}
}

function ultralight_view_render( _view, _x, _y ) {
	if (surface_exists(_view.surface) == false) {
		_view.surface = surface_create(_view.width, _view.height);	
	}
	
	if (ultralight_view_copy(_view.view, buffer_get_address(_view.buffer)) == 1) {
		buffer_set_surface(_view.buffer, _view.surface, 0);
	}
	
	_view.offset[0] = _x;
	_view.offset[1] = _y;
	draw_rectangle_colour(_x, _y, _x + _view.width, _y + _view.height, c_red, c_red, c_red, c_red, true);
	shader_set(ultralight_passthrough);
	draw_surface(_view.surface, _x, _y);
	shader_reset();
}

function ultralight_view_resize( _view, _width, _height ) {
	if (_view.width != _width || _view.height != _height) {
		if (surface_exists(_view.surface) == true) surface_free(_view.surface);
		_view.surface = surface_create(_width, _height);
		buffer_delete(_view.buffer);
		_view.buffer = buffer_create(_width * _height * 4, buffer_fixed, 1);
		_view.width = _width;
		_view.height = _height;
	}
}

/// @function ultralight_view_focus( _view, _focus, [_removeall=true] )
/// @argument {real} _view - The view to modify
/// @argument {bool} _focus - If the view should be focused or not
/// @argument {bool} [_removeall=true] - If all views focused should be unfocused
function ultralight_view_focus( _view, _focus, _removeall ) {
	if (_removeall == undefined || _removeall == true) {
		for(var i = 0, _i = array_length(__ultralight_views); i < _i; i++) {
			var _view_get = __ultralight_views[i];
			__ultralight_view_focus(_view_get.view, false);
			_view_get.focus = false;
		}
	}
	__ultralight_view_focus(_view.view, _focus);
	_view.focus = _focus;
}

function ultralight_view_bind( _view, _func, _callback ) {
	__ultralight_binding[? _func] = [method_get_index(_callback), _view];
	__ultralight_view_bind(_view.view, _func);
}

function ultralight_update( _mx, _my ) {
	var _keypress = false;
	buffer_seek(__ultralight_keybuffer, buffer_seek_start, 0);
	for(var i = 0, _i = array_length(__ultralight_keylist); i < _i; i++) {
		var _key = 0;
		if (keyboard_check_pressed(__ultralight_keylist[i]) == true) _key = 1;
		if (keyboard_check_released(__ultralight_keylist[i]) == true) _key = 2;
		buffer_write(__ultralight_keybuffer, buffer_u8, _key ? 1 : 0);
		if (_key == true) _keypress = true;
	}
	
	for(var i = 0, _i = array_length(__ultralight_views); i < _i; i++) {
		var _view = __ultralight_views[i],
			_viewmx = _mx - _view.offset[0],
			_viewmy = _my - _view.offset[1];
			
		// Mouse Input
		var _mbl = mouse_check_button_pressed(mb_left);
		if (__ultralight_autofocus == true && (_mbl == true && _view.focus == false)) {
			if (point_in_rectangle(_mx, _my, _view.offset[0], _view.offset[1], _view.offset[0] + _view.width, _view.offset[1] + _view.height) == true) {
				ultralight_view_focus(_view, true);
			}
		}
		
		if (_view.focus == true) {
			if (_mbl == true) __ultralight_event_mousedown(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Left);
			else if (mouse_check_button_released(mb_left) == true) __ultralight_event_mouseup(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Left);
			if (mouse_check_button_pressed(mb_right) == true) __ultralight_event_mousedown(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Right);
			else if (mouse_check_button_released(mb_right) == true) __ultralight_event_mouseup(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Right);
			if (mouse_wheel_up() == true) __ultralight_event_wheelup(_view.view);
			else if (mouse_wheel_down() == true) __ultralight_event_wheeldown(_view.view);
			if (_mx != _view.mouse[0] || _my != _view.mouse[1]) {
				__ultralight_event_mousemove(_view.view, _viewmx, _viewmy);
				_view.mouse[0] = _mx;
				_view.mouse[1] = _my;	
			}
		
			// Keyboard Input
			if (keyboard_string != "") {
				__ultralight_event_keyboardinput(_view.view, keyboard_string);
				keyboard_string = "";
			}
			
			if (_keypress == true) {
				__ultralight_event_keyboardpress(_view.view, buffer_get_address(__ultralight_keybuffer));	
			}
		}
		/*
		if (mouse_check_button_pressed(mb_left) == true) {
			__ultralight_event_mousedown(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Left);
			if (__ultralight_autofocus == true && _view.focus == false) {
				if (point_in_rectangle(_mx, _my, _view.offset[0], _view.offset[1], _view.offset[0] + _view.width, _view.offset[1] + _view.height) == true) {
					ultralight_view_focus(_view, true);
					show_debug_message("focused view " + string(_view.view));
				}
			}
		} else if (mouse_check_button_released(mb_left) == true) __ultralight_event_mouseup(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Left);
		if (mouse_check_button_pressed(mb_right) == true) __ultralight_event_mousedown(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Right);
		else if (mouse_check_button_released(mb_right) == true) __ultralight_event_mouseup(_view.view, _viewmx, _viewmy, UltralightButton.kButton_Right);
		if (_mx != _view.mouse[0] || _my != _view.mouse[1]) {
			__ultralight_event_mousemove(_view.view, _viewmx, _viewmy);
			_view.mouse[0] = _mx;
			_view.mouse[1] = _my;	
		}
		
		// Keyboard Input
		if (keyboard_string != "") {
			__ultralight_event_keyboardinput(_view.view, keyboard_string);
			keyboard_string = "";
		}
		*/
	}
	__ultralight_update();
}