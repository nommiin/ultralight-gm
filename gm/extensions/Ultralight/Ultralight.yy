{
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": -1,
  "extensionVersion": "0.0.1",
  "packageId": "",
  "productId": "",
  "author": "",
  "date": "2021-01-25T18:07:27.9994082-06:00",
  "license": "",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "installdir": "",
  "files": [
    {"filename":"Ultralight-GM.dll","origname":"","init":"ultralight_init","final":"","kind":4,"uncompress":false,"functions":[
        {"externalName":"ultralight_init","kind":4,"help":"ultralight_init()","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"ultralight_init","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_session_create","kind":4,"help":"ultralight_session_create( _persistent, _name )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"ultralight_session_create","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_create","kind":4,"help":"ultralight_view_create( _width, _height, _transparent, [session=null] )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_view_create","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_session_name","kind":4,"help":"ultralight_session_name( _session )","hidden":false,"returnType":1,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ultralight_session_name","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_load","kind":4,"help":"ultralight_view_load( _view, _code, _url )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
            2,
          ],"resourceVersion":"1.0","name":"ultralight_view_load","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_copy","kind":4,"help":"ultralight_view_copy( _view, _buffer )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"ultralight_view_copy","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_update","kind":4,"help":"__ultralight_update()","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"__ultralight_update","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_render","kind":4,"help":"ultralight_render()","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"ultralight_render","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_resize","kind":4,"help":"__ultralight_view_resize( _view, _width, _height )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_view_resize","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_reload","kind":4,"help":"ultralight_view_reload( _view )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
          ],"resourceVersion":"1.0","name":"ultralight_view_reload","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_event_mousemove","kind":4,"help":"ultralight_event_mousemove( _view, _mx, _my )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_event_mousemove","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_event_mousedown","kind":4,"help":"__ultralight_event_mouseup( _view, _x, _y, _button )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_event_mousedown","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_event_mouseup","kind":4,"help":"__ultralight_event_mouseup( _view, _x, _y, _button )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_event_mouseup","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_focus","kind":4,"help":"ultralight_view_focus( _view, _focus )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            2,
          ],"resourceVersion":"1.0","name":"__ultralight_view_focus","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_event_keyboardinput","kind":4,"help":"__ultralight_event_keyboardinput( _view, _input )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"__ultralight_event_keyboardinput","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_event_keyboardpress","kind":4,"help":"__ultralight_event_keyboardpress( _view, _buffer )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"__ultralight_event_keyboardpress","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_eval","kind":4,"help":"ultralight_view_eval( _view, _code )","hidden":false,"returnType":1,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"ultralight_view_eval","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"RegisterCallbacks","kind":4,"help":"RegisterCallbacks()","hidden":false,"returnType":1,"argCount":0,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"RegisterCallbacks","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ultralight_view_bind","kind":4,"help":"__ultralight_view_bind( _view, _func )","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"__ultralight_view_bind","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[],"ProxyFiles":[],"copyToTargets":-1,"order":[
        {"name":"RegisterCallbacks","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_init","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_render","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_update","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_session_create","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_session_name","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_view_create","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_view_resize","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_view_load","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_view_copy","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_view_reload","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"ultralight_view_eval","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_view_bind","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_event_mousemove","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_event_mousedown","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_event_mouseup","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_view_focus","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_event_keyboardinput","path":"extensions/Ultralight/Ultralight.yy",},
        {"name":"__ultralight_event_keyboardpress","path":"extensions/Ultralight/Ultralight.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
  ],
  "classname": "",
  "tvosclassname": null,
  "tvosdelegatename": null,
  "iosdelegatename": "",
  "androidclassname": "",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": "",
  "maclinkerflags": "",
  "tvosmaclinkerflags": "",
  "iosplistinject": null,
  "tvosplistinject": null,
  "androidinject": null,
  "androidmanifestinject": null,
  "androidactivityinject": null,
  "gradleinject": null,
  "iosSystemFrameworkEntries": [],
  "tvosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
  "IncludedResources": [],
  "androidPermissions": [],
  "copyToTargets": -1,
  "iosCocoaPods": "",
  "tvosCocoaPods": "",
  "iosCocoaPodDependencies": "",
  "tvosCocoaPodDependencies": "",
  "parent": {
    "name": "Ultralight",
    "path": "folders/Ultralight.yy",
  },
  "resourceVersion": "1.2",
  "name": "Ultralight",
  "tags": [],
  "resourceType": "GMExtension",
}