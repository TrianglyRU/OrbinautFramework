//
// Wave shader
//	
	precision highp float;
	precision highp sampler2D;

	varying vec2 v_vTexcoord;
	varying vec2 v_vPosition;
	varying vec4 v_vColour;

	uniform float g_WaveY1;
	uniform float g_WaveY2;
	uniform float g_Bound1;	
	uniform float g_Bound2;
	uniform float g_Bound3;
	uniform float g_ScreenWid;

	uniform vec3 g_DataParams1;
	uniform vec3 g_DataParams2;

	uniform sampler2D g_WaveData1;
	uniform sampler2D g_WaveData2;
	
	float WaveOffset(sampler2D WaveData, vec3 DataParams, float WaveY)
	{
		vec3  Data   = texture2D(WaveData, DataParams.xy).rgb * 255.;
		float Index  = floor(mod(WaveY + gl_FragCoord.y, Data.r + Data.g * 100.) + 1.);
		vec2  TexPos = vec2(DataParams.x, DataParams.y + Index * DataParams.z);
		vec3  Tex    = texture2D(WaveData, TexPos).rgb * 255.;

		return (Tex.r + Tex.g * 100.) * (Tex.b - 2.) / g_ScreenWid;
	}
	
	void main()
	{
		vec2 OutPos = v_vTexcoord;

		if (!((g_Bound1 >= gl_FragCoord.y) || (g_Bound3 < gl_FragCoord.y)))
		{
			if (g_Bound2 > gl_FragCoord.y)
			{
				OutPos.x += WaveOffset(g_WaveData1, g_DataParams1, g_WaveY1);
			}
			else
			{
				OutPos.x += WaveOffset(g_WaveData2, g_DataParams2, g_WaveY2);
			}
    		}

    		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
	}
