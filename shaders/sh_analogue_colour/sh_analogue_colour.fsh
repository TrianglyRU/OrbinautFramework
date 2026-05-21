varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float snapToNearest(float value)
{
    float allowed[8];
	
    allowed[0] = 0.0;
    allowed[1] = 52.0;
    allowed[2] = 87.0;
    allowed[3] = 116.0;
    allowed[4] = 144.0;
    allowed[5] = 172.0;
    allowed[6] = 206.0;
    allowed[7] = 255.0;
    
    float nearest = allowed[0];
    float minDiff = abs(value - allowed[0]);
    
    for (int i = 1; i < 8; i++)
	{
        float diff = abs(value - allowed[i]);
		
        if (diff < minDiff)
		{
            minDiff = diff;
            nearest = allowed[i];
        }
    }
    
    return nearest;
}

void main()
{
    vec4 outColour = texture2D(gm_BaseTexture, v_vTexcoord) * 255.0;
    
    outColour.r = snapToNearest(outColour.r);
    outColour.g = snapToNearest(outColour.g);
    outColour.b = snapToNearest(outColour.b);
    
    gl_FragColor = (outColour / 255.0) * v_vColour;
}