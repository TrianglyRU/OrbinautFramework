//
// Screen shader
//
	precision highp float;
	
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;
	
	#define PaletteLimit 64
	
	uniform float u_bound;
	
	uniform sampler2D u_texFst;
	uniform vec3	  u_UVsFst;
	uniform vec2	  u_texSizeFst;
	uniform float     u_indFst[PaletteLimit];

	uniform sampler2D u_texSnd;
	uniform vec3      u_UVsSnd;
	uniform vec2      u_texSizeSnd;
	uniform float     u_indSnd[PaletteLimit];
	
	// This block of code is based on the shader by Pixelated Pope, which we purchased! Credits to him <3
	vec4 findAltColor(vec4 inCol, vec3 corner, vec2 pixelSize, sampler2D sampler, float palID[PaletteLimit]) 
	{
		for (float i = corner.y; i < corner.z; i += pixelSize.y) 
		{
			vec2 testPos = vec2(corner.x, i);
			if (texture2D(sampler, testPos) == inCol) 
			{
				float Index = palID[int((i - corner.y) / pixelSize.y)];
				testPos.x  += pixelSize.x * floor(Index + 1.);
				
				return mix(texture2D(sampler, vec2(testPos.x - pixelSize.x, testPos.y)), texture2D(sampler, testPos), fract(Index));
			}
		}
		return inCol;
	}
	
	uniform bool  u_parallaxActive;
	uniform vec2  u_pos;
	uniform float u_width;
	uniform float u_yScale;
	uniform float u_offset;
	uniform float u_ilHeight;
	uniform float u_ilStep;
	uniform float u_mapSize;
	
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
		OutX   = u_offset;
		if (u_ilHeight > 0.)
		{
			RowX = floor(CurPos.y / u_ilHeight / u_yScale);
			if (u_ilStep < 0.)
			{
				RowX += 1.;
			}
			OutX *= RowX * u_ilStep + 1.;
		}
		OutX = mod(floor(OutX) + CurPos.x, u_width) - CurPos.x;
		OutPos = vec2(v_vTexcoord.x + OutX / u_mapSize, v_vTexcoord.y);

	    return OutPos;
	}
	
	void main() 
	{
		vec4 Col = texture2D(gm_BaseTexture, parallax());
		
		//if  (u_bound <= v_vPosition.y)
		if  (u_bound <= gl_FragCoord.y)
		{
			Col = findAltColor(Col, u_UVsSnd, u_texSizeSnd, u_texSnd, u_indSnd);
		}
		else
		{
			Col = findAltColor(Col, u_UVsFst, u_texSizeFst, u_texFst, u_indFst);
		}
		
		gl_FragColor = Col * v_vColour;
	}