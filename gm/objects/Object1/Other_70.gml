switch (async_load[? "event_type"]) {
	case "ultralight_callback": {
		var _bind = __ultralight_binding[? async_load[? "event_func"]], _func = _bind[0];
		if (_func != undefined) {
			method(_bind[1], _func)();	
		}
		break;	
	}
}