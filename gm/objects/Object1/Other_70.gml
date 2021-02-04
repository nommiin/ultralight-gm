switch (async_load[? "event_type"]) {
	case "ultralight_callback": {
		var _bind = __ultralight_binding[? async_load[? "event_func"]], _func = _bind[0];
		if (_func != undefined) {
			var _arg = json_parse(async_load[? "event_arguments"]);
			with (_bind[1]) {
				script_execute_ext(_func, _arg.data);
			}
		}
		break;	
	}
}