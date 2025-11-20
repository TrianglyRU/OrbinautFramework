//
// Distortion shader
//	
#define WaveLimit 256

precision mediump float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_WaveY1;
uniform float g_WaveY2;
uniform float g_Bound1;	
uniform float g_Bound2;
uniform float g_Bound3;
uniform float g_ScreenWid;
uniform float g_WaveHeight1;
uniform float g_WaveHeight2;

uniform float g_WaveData1[WaveLimit];
uniform float g_WaveData2[WaveLimit];

vec4 Col;

void main()
{
	vec2 OutPos = v_vTexcoord;
	if (!((g_Bound1 >= gl_FragCoord.y) || (g_Bound3 < gl_FragCoord.y)))
	{
		if (g_Bound2 > gl_FragCoord.y)
		{
			OutPos.x -= g_WaveData1[int(mod(g_WaveY1 + gl_FragCoord.y, g_WaveHeight1))] / g_ScreenWid;
		}
		else
		{
			OutPos.x -= g_WaveData2[int(mod(g_WaveY2 + gl_FragCoord.y, g_WaveHeight2))] / g_ScreenWid;
		}
	}
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, OutPos);
}