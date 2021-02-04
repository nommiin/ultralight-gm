# ultralight-gm
An implementation of the Ultralight library for GameMaker Studio 2.3 (x64)

# Usage
1. Create a view using `ultralight_view_create( _width, _height, _transparent, [_session=undefined] )`
2. Load HTML or a URL using `ultralight_view_load( _view[.view], _str, _url )`
3. Call `ultralight_update( _mousex, _mousey )` in the step event to pass mouse+keyboard inputs and `ultralight_render()` in the draw event
4. Use `ultralight_view_draw( _view, _x, _y )` to draw the view

# Functions
### High-Level Functions:
```js
/// @function ultralight_update( _mx, _my )
/// @description Will update all views with current keyboard and mouse input (and position), must be called every frame
/// @argument {number} _mx - The horizontal mouse position
/// @argument {number} _my - The vertical mouse position

/// @function ultralight_render()
/// @description Will call the renderer to render any dirty views, must be called every frame

/// @function ultralight_view_create( _width, _height, _transparent, _session )
/// @description Creates a struct containing various members required by other GML functions to update and render the view
/// @argument {number} _width - The width of the view
/// @argument {number} _height - The height of the view
/// @argument {bool} _transparent - If the view should be transparent or not
/// @argument {number} [_session=undefined] - The session to use for the view, retains localStorage and other things; not required
/// @returns {struct} A struct containing different members relating to the newly created view

/// @function ultralight_view_render( _view, _x, _y )
/// @description Renders an Ultralight view, handles surface creation, copies the view bitmap if needed, and sets view passthrough shader to swap red and blue channels
/// @argument {struct} _view - The struct for the view to be drawn
/// @argument {number} _x - The horizontal position to draw the view at
/// @argument {number} _y - The vertical position to draw the view at

/// @function ultralight_view_focus( _view, _focus, [_removeall=true] )
/// @description Focus/unfocuses a given view, if __ultralight_autofocus is true then the function will automatically unfocus all views except for the given view
/// @argument {struct} _view - The view to set focus for
/// @argument {bool} _focus - If the view should be focused (true) or unfocused (false)
/// @argument {bool} [_removeall=true] - If all other views should be unfocused, if not provided then __ultralight_autofocus will be checked

/// @function ultralight_view_bind( _view, _func, _callback )
/// @description Allows you to bind a GML callback to a JS function
/// @argument {struct} _view - The view to bind the callback to
/// @argument {string} _func - The name of the function to bind the callback to
/// @argument {method} _callback - The GML function to call when a callback is recieved from the JS function

/// @function ultralight_session_create( _persistent, _name )
/// @description Creates a new session that can be provided to a view
/// @argument {bool} _persistent - If the session should be kept persistent between launches
/// @argument {string} _name - The name to refer to the session as
```
### Low-Level Functions:
These are considered low level functions because most are used by the extension itself or take the view index as an argument rather than the view struct itself. You can access this view index with the `.view` member of the view struct.
```js
/// @function ultralight_init()
/// @description Initializes platform and configuration settings for Ultralight, this is automatically called by the extension itself so it is recommended NOT to call manually

/// @function __ultralight_update()
/// @description Will update the renderer, this is manually called by ultralight_update and is normally not required to be called manually

/// @function ultralight_view_eval( _view[.view], _code )
/// @description Executes the given JS code for the view and returns the result as a string
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {string} _code - The code to execute for the view
/// @returns {string} - The evaluated result from the code

/// @function __ultralight_view_create( _width, _height, _transparent, _session )
/// @description Internal function to create a view and retireve the index for it, this is called by ultralight_view_create
/// @argument {number} _width - The width of the view
/// @argument {number} _height - The height of the view
/// @argument {bool} _transparent - If the view should be transparent or not
/// @argument {number} _session - The session to use for the view, required for function call (provide -1 if no session is needed)

/// @function __ultralight_view_focus( _view, _focus )
/// @description Focuses a given view, normally called by ultralight_view_focus but can be used for more control
/// @argument {number} _view - The index tied to the view
/// @argument {bool} _focus - If the view should be focused (true) or unfocused (false)

/// @function __ultralight_event_mousemove( _view[.view], _mx, _my )
/// @description Fires a "mouse move" event for the view, this is handled by ultralight_update
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {number} _mx - The horizontal mouse position
/// @argument {number} _my - The vertical mouse position

/// @function __ultralight_event_mouseup( _view[.view], _x, _y, _button )
/// @description Fires a "mouse released" event for the view, this is handled by ultralight_update
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {number} _mx - The horizontal mouse position
/// @argument {number} _my - The vertical mouse position
/// @argument {number} _button - The mouse button being released, uses UltralightButton enum (does not map to GM constants)

/// @function __ultralight_event_mousedown( _view[.view], _x, _y, _button )
/// @description Fires a "mouse pressed" event for the view, this is handled by ultralight_update
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {number} _mx - The horizontal mouse position
/// @argument {number} _my - The vertical mouse position
/// @argument {number} _button - The mouse button being pressed, uses UltralightButton enum (does not map to GM constants)

/// @function __ultralight_event_keyboardinput( _view[.view], _input )
/// @description Fires a "type characters" event for the view, this is handled by ultralight_update
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {string} _input - The text being typed (usually keyboard_string)

/// @function __ultralight_event_keyboardpress( _view[.view], _bufferaddr )
/// @description Fires a "key down" or "key up" event for the view, this is handled by ultralight_update
/// @argument {number} _view[.view] - The index tied to the view
/// @argument {pointer} _bufferaddr - The address to the buffer containing keyboard input states, buffer must be KEY_COUNT bytes long and contain either 0 (none), 1 (pressed), or 2 (released)
```

# Notes
Here are some miscellaneous notes about using the Ultralight-GM API
- There are five internal globalvars used for various reasons outlined below:
  - \_\_ultralight_views: An array containing all views created using ultralight_view_create
  - \_\_ultralight_autofocus: A boolean value used to determine if view focus should be automatically determined by checking the left mouse button and the position of the mouse
  - \_\_ultralight_binding: A `ds_map` with keys (JS function name) containing tuples for each method and view struct for callbacks
  - \_\_ultralight_keylist: An array containing every key to check when calling `ultralight_update`, if changed be sure to change the `KEY_COUNT` macro in `main.cpp` for the DLL
  - \_\_ultralight_keybuffer: A buffer that is `array_length(__ultralight_keylist)` bytes long, containing 1 byte for each key. Sent to the DLL using `__ultralight_event_keyboardpress`
- Note that some internal functions (namely `ultralight_view_eval`) take the view index instead of the view struct
- The `ultralight_passthrough` shader must be used when manually rendering view surfaces due to GameMaker's swapped red and blue channels in surfaces.
- Both `ultralight_view_copy` and `__ultralight_event_keyboardpress` functions use **buffer addresses** instead of buffer indices
