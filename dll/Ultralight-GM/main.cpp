#define GM_EXPORT extern "C" __declspec (dllexport)
#define GM_BOOL(a) a >= 0.5 ? true : false
#define KEY_COUNT 21

#include <Ultralight/Ultralight.h>
#include <AppCore/Platform.h>
#include <JavaScriptCore/JavaScript.h>
#include <vector>
#include <windows.h>
#include <wchar.h>
#include <string.h>
#include <string>
#include <iostream>
#include "async.h"

using namespace ultralight;
using namespace std;
RefPtr<Renderer> renderer;
vector<RefPtr<View>> views;
vector<RefPtr<Session>> sessions;
int keymap[KEY_COUNT] = {
	KeyCodes::GK_TAB,
	KeyCodes::GK_LEFT,
	KeyCodes::GK_RIGHT,
	KeyCodes::GK_UP,
	KeyCodes::GK_DOWN,
	KeyCodes::GK_PRIOR,
	KeyCodes::GK_NEXT,
	KeyCodes::GK_HOME,
	KeyCodes::GK_END,
	KeyCodes::GK_INSERT,
	KeyCodes::GK_DELETE,
	KeyCodes::GK_BACK,
	KeyCodes::GK_SPACE,
	KeyCodes::GK_RETURN,
	KeyCodes::GK_ESCAPE,
	KeyCodes::GK_CONTROL,
	KeyCodes::GK_LCONTROL,
	KeyCodes::GK_RCONTROL,
	KeyCodes::GK_C,
	KeyCodes::GK_V,
	KeyCodes::GK_Z
};

char* JSStringToCString(JSStringRef _str) {
	size_t buff_size = JSStringGetMaximumUTF8CStringSize(_str);
	if (buff_size > 0) {
		char* buff = new char[buff_size];
		JSStringGetUTF8CString(_str, buff, buff_size);
		return buff;
	}
	return nullptr;
}

std::string JSValueToString(JSContextRef _ctx, JSValueRef _val) {
	std::string str_val("");
	switch (JSValueGetType(_ctx, _val)) {
		case JSType::kJSTypeNumber:
		{
			str_val = std::to_string(JSValueToNumber(_ctx, _val, nullptr));
			break;
		}

		case JSType::kJSTypeString:
		{
			JSStringRef arg_ref = JSValueToStringCopy(_ctx, _val, nullptr);
			str_val = "\"" + std::string(JSStringToCString(arg_ref)) + "\"";
			JSStringRelease(arg_ref);
			break;
		}

		case JSType::kJSTypeNull:
		{
			str_val = "null";
			break;
		}

		case JSType::kJSTypeUndefined:
		{
			str_val = "undefined";
			break;
		}
	}
	return str_val;
}

GM_EXPORT double ultralight_init() {
	// Setup default configuration
	Config config;
	config.resource_path = "./resources/";
	config.use_gpu_renderer = false;
	config.device_scale = 1;
	config.font_family_standard = "Arial";
	auto& platform_inst = Platform::instance();
	platform_inst.set_config(config);

	// Initalize platform handlers
	platform_inst.set_font_loader(GetPlatformFontLoader());
	platform_inst.set_file_system(GetPlatformFileSystem("."));
	platform_inst.set_logger(GetDefaultLogger("ultralight.log"));
	renderer = Renderer::Create();
	return 1;
}

GM_EXPORT double ultralight_update() {
	renderer->Update();
	return 1;
}

GM_EXPORT double ultralight_render() {
	renderer->Render();
	return 1;
}

GM_EXPORT double ultralight_session_create(double _persistent, char* _name) {
	sessions.push_back(renderer->CreateSession(GM_BOOL(_persistent), _name));
	return (double)sessions.size() - 1;
}

GM_EXPORT double ultralight_view_create(double _width, double _height, double _transparent, double _session) {
	if (_session == -1 || (_session >= 0 && _session < sessions.size())) {
		views.push_back(renderer->CreateView(static_cast<uint32_t>(_width), static_cast<uint32_t>(_height), GM_BOOL(_transparent), (_session != -1 ? sessions.at(static_cast<uint32_t>(_session)) : nullptr)));
		return (double)views.size() - 1;
	} else return -1;
}

GM_EXPORT double ultralight_view_load(double _view, char* _code, double _url) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		if (GM_BOOL(_url) == true) {
			view->LoadURL(_code);
		} else view->LoadHTML(_code);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_view_copy(double _view, char* _buffer) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		BitmapSurface* surface = (BitmapSurface*)(view->surface());
		if (surface->dirty_bounds().IsEmpty() == false) {
			RefPtr<Bitmap> bitmap = surface->bitmap();
			memcpy(_buffer, bitmap->LockPixels(), static_cast<uint32_t>(bitmap->width()) * static_cast<uint32_t>(bitmap->height()) * 4);
			bitmap->UnlockPixels();
			surface->ClearDirtyBounds();
			return 1;
		}
		return 0;
	} else return -1;
}

GM_EXPORT double ultralight_view_resize(double _view, double _width, double _height) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		view->Resize(static_cast<uint32_t>(_width), static_cast<uint32_t>(_height));
		view->set_needs_paint(true);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_view_reload(double _view) {
	if (_view >= 0 && _view < views.size()) {
		views.at(static_cast<uint32_t>(_view))->Reload();
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_view_focus(double _view, double _focus) {
	if (_view >= 0 && _view < views.size()) {
		if (GM_BOOL(_focus) == true) {
			views.at(static_cast<uint32_t>(_view))->Focus();
		} else views.at(static_cast<uint32_t>(_view))->Unfocus();
		return 1;
	}
	return 0;
}

GM_EXPORT char* ultralight_view_eval(double _view, char* _code) {
	if (_view >= 0 && _view < views.size()) {
		String16 _str = views.at(static_cast<uint32_t>(_view))->EvaluateScript(_code).utf16();
		char* _char = new char[_str.length()];
		WideCharToMultiByte(CP_UTF8, 0, _str.data(), -1, _char, strlen(_char), NULL, NULL);
		return _char;
	}
	return 0;
}

JSValueRef ultralight_event_callback(JSContextRef ctx, JSObjectRef func, JSObjectRef thisObject, size_t argc, const JSValueRef arguments[], JSValueRef* exception) {
	// Create map and add "event_type" string
	int mapCallback = CreateMap();
	DsMapAddString(mapCallback, _strdup("event_type"), _strdup("ultralight_callback"));

	// Get "name" property from calling function and store in map
	JSStringRef prop_name = JSStringCreateWithUTF8CString("name");
	JSValueRef func_prop = JSObjectGetProperty(ctx, func, prop_name, nullptr);
	JSStringRelease(prop_name);
	JSStringRef func_name = JSValueToStringCopy(ctx, func_prop, nullptr);
	char* func_cstr = JSStringToCString(func_name);
	if (func_cstr != nullptr) {
		DsMapAddString(mapCallback, _strdup("event_func"), func_cstr);
	}
	JSStringRelease(func_name);

	// Build an array of arguments and store in map
	std::string arg_data("{\"data\": [");
	for (int i = 0; i < argc; i++) {
		arg_data += JSValueToString(ctx, arguments[i]) + (i < argc - 1 ? ", " : "");
	}
	arg_data += "]}";
	char* arg_str = new char[arg_data.length() + 1];
	strcpy_s(arg_str, arg_data.length() + 1, arg_data.c_str());
	DsMapAddString(mapCallback, _strdup("event_arguments"), arg_str);
	CallAsync(mapCallback);
	return JSValueMakeNull(ctx);
}

GM_EXPORT double ultralight_view_bind(double _view, char* _func) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		Ref<JSContext> ctx = view->LockJSContext();
		JSContextRef ctx_ref = ctx.get();
		JSStringRef func_name = JSStringCreateWithUTF8CString(_func);

		JSObjectRef cb = JSObjectMakeFunctionWithCallback(ctx_ref, func_name, ultralight_event_callback);
		JSObjectSetProperty(ctx_ref, JSContextGetGlobalObject(ctx_ref), func_name, cb, 0, 0);

		JSStringRelease(func_name);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_mousemove(double _view, double _mx, double _my) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		MouseEvent evt;
		evt.type = MouseEvent::kType_MouseMoved;
		evt.x = static_cast<int>(_mx);
		evt.y = static_cast<int>(_my);
		evt.button = MouseEvent::kButton_None;
		view->FireMouseEvent(evt);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_mousedown(double _view, double _mx, double _my, double _button) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		MouseEvent evt;
		evt.type = MouseEvent::kType_MouseDown;
		evt.x = static_cast<int>(_mx);
		evt.y = static_cast<int>(_my);
		evt.button = static_cast<MouseEvent::Button>(_button);
		view->FireMouseEvent(evt);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_mouseup(double _view, double _mx, double _my, double _button) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		MouseEvent evt;
		evt.type = MouseEvent::kType_MouseUp;
		evt.x = static_cast<int>(_mx);
		evt.y = static_cast<int>(_my);
		evt.button = static_cast<MouseEvent::Button>(_button);
		view->FireMouseEvent(evt);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_wheelup(double _view) {
	if (_view >= 0 && _view < views.size()) {
		/*RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		MouseEvent evt;
		evt.type = MouseEvent::k
		evt.x = static_cast<int>(_mx);
		evt.y = static_cast<int>(_my);
		evt.button = static_cast<MouseEvent::Button>(_button);
		view->FireMouseEvent(evt);*/
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_keyboardinput(double _view, char* _input) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		KeyEvent evt;
		evt.type = KeyEvent::kType_Char;
		evt.text = _input;
		evt.unmodified_text = _input;
		view->FireKeyEvent(evt);
		return 1;
	}
	return 0;
}

GM_EXPORT double ultralight_event_keyboardpress(double _view, char* _buffer) {
	if (_view >= 0 && _view < views.size()) {
		RefPtr<View> view = views.at(static_cast<uint32_t>(_view));
		for (int i = 0; i < KEY_COUNT; i++) {
			char _keytype = _buffer[i];
			if (_keytype != 0) {
				KeyEvent evt;
				evt.type = (_keytype == 1 ? KeyEvent::kType_RawKeyDown : KeyEvent::kType_KeyUp);
				evt.virtual_key_code = keymap[i];
				evt.native_key_code = 0;
				evt.modifiers = 0;
				GetKeyIdentifierFromVirtualKeyCode(evt.virtual_key_code, evt.key_identifier);
				view->FireKeyEvent(evt);
			}
		}
		return 1;
	}
	return 0;
}