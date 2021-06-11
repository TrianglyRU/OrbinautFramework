// Simple passthrough fragment shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec2 outCoord = v_vTexcoord;
	
	// Flip vertically 
	//outCoord.y = -outCoord.y + 1.;
	
	//Flip horizontally 
	//outCoord.x = -outCoord.x + 1.;
	
	vec4 outTex = texture2D(gm_BaseTexture, outCoord);
	
	// Black&White
	//float Mixed = (outTex.r + outTex.g + outTex.b) / 3.;
	//outTex.rgb = vec3(Mixed, Mixed, Mixed);
	
	// Sepia
	//float Mixed = (outTex.r + outTex.g + outTex.b) / 3.;
	//outTex.rgb = vec3(Mixed, Mixed, Mixed / 1.5);
	
	// Negative
	//outTex.rgb = 1. - outTex.rgb;
	
    gl_FragColor = v_vColour * outTex;
}
