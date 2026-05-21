varying vec2 v_vTexcoord;
varying vec4 v_vColour;

bool isValueValid(float value)
{
    if (abs(value - 0.0)   < 0.5) return true;
    if (abs(value - 36.0)  < 0.5) return true;
    if (abs(value - 73.0)  < 0.5) return true;
    if (abs(value - 109.0) < 0.5) return true;
    if (abs(value - 146.0) < 0.5) return true;
    if (abs(value - 182.0) < 0.5) return true;
    if (abs(value - 219.0) < 0.5) return true;
    if (abs(value - 255.0) < 0.5) return true;
	
    return false;
}

void main()
{
    vec4 outColour = texture2D(gm_BaseTexture, v_vTexcoord) * 255.0;
	
    bool rValid = isValueValid(outColour.r);
    bool gValid = isValueValid(outColour.g);
    bool bValid = isValueValid(outColour.b);
    
    if (!rValid || !gValid || !bValid)
	{
        outColour.rgb = vec3(255.0, 0., 255.0);
    }
    
    gl_FragColor = outColour / 255.0 * v_vColour;
}