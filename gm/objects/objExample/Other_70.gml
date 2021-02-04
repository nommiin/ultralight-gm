// Usual async event stuff!
switch (async_load[? "event_type"]) {
	// Check for ultralight_callback as the event_type key
	case "ultralight_callback": {
		// Retrieve binding from __ultralight_binding map with "event_func" key (name of JS function)
		var _bind = __ultralight_binding[? async_load[? "event_func"]], _func = _bind[0];
		if (_func != undefined) {
			// Parse out function arguments (JSON) and set scope to view
			var _arg = json_parse(async_load[? "event_arguments"]);
			with (_bind[1]) {
				// Call the method bound the JS function and pass argument array
				script_execute_ext(_func, _arg.data);
			}
		}
		break;	
	}
}