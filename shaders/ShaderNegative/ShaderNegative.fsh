// Negative shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 randval;

void main()
{
	vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = v_vColour * vec4(1. - col.rgb, col.a);
}
