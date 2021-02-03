//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float a = gl_FragColor.r;
	float b = gl_FragColor.b;
	gl_FragColor.r = b;
	gl_FragColor.b = a;
}
