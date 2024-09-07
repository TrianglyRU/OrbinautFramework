//
// Simple passthrough fragment shader
//
	precision highp float;
	precision highp int;
	
	#define BINARY_SEARCH 0	// Set to 1 to significantly speed up colour replacement (requires sorted palette)
	#define PALETTE_LIMIT 256 // This constant should match ENGINE_PALETTE_MAX_SLOTS macro
	
	const float LIMIT1 = 255.0;
    const float LIMIT2 = LIMIT1 * 2.0;
    const float LIMIT3 = LIMIT1 * 3.0;
	
	varying vec2 v_vTexcoord;
	varying vec4 v_vColour;
	varying vec2 v_vPosition;
	
	uniform bool u_fade_active;
	uniform int u_fade_type;
    uniform float u_fade_step;
	
	uniform bool u_pal_active;
	uniform sampler2D u_pal_tex1;
	uniform sampler2D u_pal_tex2;
	uniform vec2 u_pal_texel_size1;
	uniform vec2 u_pal_texel_size2;
	uniform vec3 u_pal_uv1;
	uniform vec3 u_pal_uv2;
	uniform float u_pal_index1[PALETTE_LIMIT];
	uniform float u_pal_index2[PALETTE_LIMIT];
	uniform float u_pal_bound;
	
	uniform bool u_bg_active;
	uniform vec4 u_bg_offset;
	uniform vec2 u_bg_pos;
	uniform vec2 u_bg_size;
	uniform vec2 u_bg_map_size;
	uniform float u_bg_scaling;
	uniform float u_bg_incline_height;
	uniform float u_bg_incline_step;
	
	// Calculate faded colour (this will combust on very low-end devices, please YoYo update your GLSL :skull:)
    vec3 getFadeColour(vec3 colour)
    {
        if (u_fade_type == 0)
        {
			return min(colour - LIMIT3 + u_fade_step + vec3(0.0, colour.r, colour.r + colour.g), colour);
        }
        else if (u_fade_type == 1)
        {
			return min(u_fade_step - vec3(colour.b + colour.g, colour.b, 0.0), colour);
        }
        else if (u_fade_type == 2)
        {
            return min(colour, u_fade_step);
        }
        else if (u_fade_type == 3)
        {
            return max(colour - max(LIMIT1 - u_fade_step, 0.0), 0.0);
        }
        else if (u_fade_type == 4)
        {
			return max(vec3(LIMIT2 - colour.b - colour.g, LIMIT1 - colour.b, 0.0) - u_fade_step + LIMIT1, colour);
        }
        else if (u_fade_type == 5)
        {
			return max(colour + LIMIT3 - u_fade_step - vec3(0.0, LIMIT1 - colour.r, LIMIT2 - colour.r - colour.g), colour);
        }
        else if (u_fade_type == 6)
        {
            return max(colour, LIMIT1 - u_fade_step);
        }
        else if (u_fade_type == 7)
        {
            return min(colour + max(LIMIT1 - u_fade_step, 0.0), LIMIT1);
        }
		
        return colour;
    }
	
	// Calculate parallax coordinate
	vec2 getParallaxCoord() 
	{		
		vec2 Position = v_vPosition - u_bg_pos;
		vec2 Offset = u_bg_offset.xy;
		
		if (u_bg_incline_height != 0.0)
		{
			Offset.x *= floor((Position.y / u_bg_scaling - u_bg_size.y) / u_bg_incline_height + 1.0) * u_bg_incline_step + 1.0;
		}
			
		Offset = mod(mod(floor(Offset) + Position - u_bg_offset.zw, u_bg_size) + u_bg_size, u_bg_size) - Position;
		Offset.y = u_bg_scaling != 0.0 ? 0.0 : Offset.y;
		
	    return v_vTexcoord + Offset / u_bg_map_size;
	}
	
	// BINARY SEARCH COLOUR SWAP
	
	#if (BINARY_SEARCH > 0)

	float getDifferenceValue(vec4 first, vec4 second)
    {
        vec4 Diff = sign(first - second) * vec4(8.0, 4.0, 2.0, 1.0);
        return Diff.r + Diff.g + Diff.b + Diff.a;
    }
	
	// Swap primary colour (above split bound)
	vec4 replaceColour1(vec4 target)
	{	
		int Left = 0;
		int Right = int((u_pal_uv1.z - u_pal_uv1.y) / u_pal_texel_size1.y) - 1;
	
		while (Left <= Right)
		{
			int Mid = (Left + Right) / 2;
			vec2 TestPosition = vec2(u_pal_uv1.x, float(Mid) * u_pal_texel_size1.y + u_pal_uv1.y);
			float Diff = getDifferenceValue(target, texture2D(u_pal_tex1, TestPosition));
			
			if (Diff > 0.0)
			{
			    Left = Mid + 1;
			}
			else if (Diff < 0.0)
			{
			    Right = Mid - 1;
			}
			else
			{
				float Index = u_pal_index1[Mid];
		        TestPosition.x += u_pal_texel_size1.x * floor(Index + 1.0);
				
				return mix(texture2D(u_pal_tex1, vec2(TestPosition.x - u_pal_texel_size1.x, TestPosition.y)), texture2D(u_pal_tex1, TestPosition), fract(Index));
			}
		}

		return target;
	}	
	
	// Swap secondary colour (below split bound)
	vec4 replaceColour2(vec4 target)
	{	
		int Left = 0;
		int Right = int((u_pal_uv2.z - u_pal_uv2.y) / u_pal_texel_size2.y) - 1;
	
		while (Left <= Right)
		{
			int Mid = (Left + Right) / 2;
			vec2 TestPosition = vec2(u_pal_uv2.x, float(Mid) * u_pal_texel_size2.y + u_pal_uv2.y);
			float Diff = getDifferenceValue(target, texture2D(u_pal_tex2, TestPosition));
			
			if (Diff > 0.0)
			{
			    Left = Mid + 1;
			}
			else if (Diff < 0.0)
			{
			    Right = Mid - 1;
			}
			else
			{
				float Index = u_pal_index2[Mid];
		        TestPosition.x += u_pal_texel_size2.x * floor(Index + 1.0);
				
				return mix(texture2D(u_pal_tex2, vec2(TestPosition.x - u_pal_texel_size2.x, TestPosition.y)), texture2D(u_pal_tex2, TestPosition), fract(Index));
			}
		}

		return target;
	}
	
	// TRADITIONAL COLOUR SWAP
	
	#else
	
	// Swap primary colour (above split bound)
	vec4 replaceColour1(vec4 target)
	{		
		for (float i = u_pal_uv1.y; i < u_pal_uv1.z; i += u_pal_texel_size1.y) 
		{
		    vec2 TestPosition = vec2(u_pal_uv1.x, i);
			
		    if (texture2D(u_pal_tex1, TestPosition) == target)
		    {
			    float Index = u_pal_index1[int((i - u_pal_uv1.y) / u_pal_texel_size1.y)];
			    TestPosition.x += u_pal_texel_size1.x * floor(Index + 1.0);
				
				return mix(texture2D(u_pal_tex1, vec2(TestPosition.x - u_pal_texel_size1.x, TestPosition.y)), texture2D(u_pal_tex1, TestPosition), fract(Index));
		    }
		}
		
		return target;
	}

	// Swap secondary colour (below split bound)
	vec4 replaceColour2(vec4 target)
	{		
		for (float i = u_pal_uv2.y; i < u_pal_uv2.z; i += u_pal_texel_size2.y) 
		{
		    vec2 TestPosition = vec2(u_pal_uv2.x, i);
			
		    if (texture2D(u_pal_tex2, TestPosition) == target)
		    {
			    float Index = u_pal_index2[int((i - u_pal_uv2.y) / u_pal_texel_size2.y)];
			    TestPosition.x += u_pal_texel_size2.x * floor(Index + 1.0);
				
				return mix(texture2D(u_pal_tex2, vec2(TestPosition.x - u_pal_texel_size2.x, TestPosition.y)), texture2D(u_pal_tex2, TestPosition), fract(Index));
		    }
		}
		
		return target;
	}
	
	#endif
	
	void main()
	{
		// Get pixel at position
		vec4 OutColour = texture2D(gm_BaseTexture, u_bg_active ? getParallaxCoord() : v_vTexcoord);
		
		// Swap colour
		if (u_pal_active)
		{
			OutColour = (u_pal_bound > gl_FragCoord.y ? replaceColour1(OutColour) : replaceColour2(OutColour)) * v_vColour;
		}
		
		// Set final colour
		gl_FragColor = u_fade_type < 0 || !u_fade_active ? OutColour : vec4(getFadeColour(OutColour.rgb * 255.0) / 255.0, OutColour.a);
	}