//
// Main Screen Shader
//
	precision highp float;
	
	#define PaletteLimit 64
	
	/* Colour Swap */
	
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;
	
	uniform float u_bound;
	
	uniform sampler2D u_texFst;
	uniform vec3	  u_UVsFst;
	uniform vec2	  u_texSizeFst;
	uniform float     u_indFst[PaletteLimit];

	uniform sampler2D u_texSnd;
	uniform vec3      u_UVsSnd;
	uniform vec2      u_texSizeSnd;
	uniform float     u_indSnd[PaletteLimit];
	
	// This is a heavy modification of function from the shader by Pixelated Pope. Credits to him!
	vec4 findAltColor(vec4 inCol, vec3 corner, vec2 pixelSize, sampler2D sampler, float palID[PaletteLimit]) 
    {
        for (float i = corner.y; i < corner.z; i += pixelSize.y) 
        {
            vec2 testPos = vec2(corner.x, i);
            if (texture2D(sampler, testPos).rgb == inCol.rgb) 
            {
                float Index = palID[int((i - corner.y) / pixelSize.y)];
                testPos.x  += pixelSize.x * floor(Index + 1.);
                
                if (inCol.a == 1.)
                {
                    return mix(texture2D(sampler, vec2(testPos.x - pixelSize.x, testPos.y)), texture2D(sampler, testPos), fract(Index));
                }
                else
                {
                    return vec4(mix(texture2D(sampler, vec2(testPos.x - pixelSize.x, testPos.y)).rgb, texture2D(sampler, testPos).rgb, fract(Index)), inCol.a);
                }
            }
        }
        return inCol;
    }
	
	/* Background Parallax */
	
	uniform bool  u_parallaxActive;
	uniform vec2  u_pos;
	uniform float u_width;
	uniform float u_scaleY;
	uniform vec2  u_offset;
	uniform float u_ilHeight;
	uniform float u_ilStep;
	uniform float u_mapSize;
	uniform float u_height;
	
	vec2  CurPos;
	vec2  OutPos;
	float RowX;
	float OutX;
	
	vec2 parallax() 
	{	
		if (u_parallaxActive == false) 
		{
			return v_vTexcoord;
		}
		
		CurPos = v_vPosition - u_pos;
		OutX   = u_offset.x;
		if (u_ilHeight != 0.)
		{
			RowX = floor((CurPos.y / u_scaleY - u_height) / u_ilHeight);
			if (u_ilStep < 0.)
			{
				RowX += 1.;
			}
			OutX *= RowX * u_ilStep + 1.;
		}
		OutX = mod(mod(floor(OutX) + CurPos.x - u_offset.y, u_width) + u_width, u_width) - CurPos.x;
		OutPos = vec2(v_vTexcoord.x + OutX / u_mapSize, v_vTexcoord.y);

	    return OutPos;
	}
	
	// A fix of a stupid GLSL bug. We won't go into details here
	uniform sampler2D bugfix1;
	uniform sampler2D bugfix2;
	
	/* Process */
	
	void main() 
	{
		vec4 Col = texture2D(gm_BaseTexture, parallax());
		
		texture2D(bugfix1, vec2(0.));
		texture2D(bugfix2, vec2(0.));
		
		if (u_bound <= gl_FragCoord.y)
		{
			Col = findAltColor(Col, u_UVsSnd, u_texSizeSnd, u_texSnd, u_indSnd);
		}
		else
		{
			Col = findAltColor(Col, u_UVsFst, u_texSizeFst, u_texFst, u_indFst);
		}
		
		gl_FragColor = Col * v_vColour;
	}