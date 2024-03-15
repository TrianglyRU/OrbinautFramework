#include "GameMaker.fxh"

// compile as:
// fxc /Ges /Vi /T fx_2_0 /Fo _filter_waves.fxb _filter_waves.fx

// Attributes
attribute vec3 in_Position;
attribute vec3 in_Normal; // (usually unused)
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

// aka GLSL vars:
// GLSL ES has only one render target, so one element in the array.
// if we had more than one target, we'd increment this array's size.
static vec4 gl_Color[1];
static vec4 gl_Position;

varying vec2 v_vTexcoord;
varying vec2 v_vPosition;
varying vec4 v_vColour;

// registers s0 and c0 are reserved by GameMaker.fxh and are passed by the IDE
// they should NOT be used.

// uniforms go here:
uniform float g_WaveY1 : register(c1);
uniform float g_WaveY2 : register(c2);
uniform float g_Bound1 : register(c3);	
uniform float g_Bound2 : register(c4);
uniform float g_Bound3 : register(c5);
uniform float g_ScreenWid : register(c6);

uniform vec4 g_DataParams1 : register(c7);
uniform vec4 g_DataParams2 : register(c8);

uniform sampler2D g_WaveData1 : register(s1);
uniform sampler2D g_WaveData2 : register(s2);

// Vertex Shader main:
void Vgl_main()
{
    gl_Position = mul(vec4(in_Position.xyz, 1.), MVPTransform);
    v_vTexcoord = in_TextureCoord;
    v_vPosition = in_Position.xy;
    v_vColour   = in_Colour;
}

// Fragment Shader main:
float WaveOffset(sampler2D WaveData, vec3 DataParams, float WaveY)
{
	vec3  Data   = gltexture2D(WaveData, DataParams.xy).rgb * 255.;
	float Index  = floor(mod(WaveY + gl_FragCoord.y, Data.r + Data.g * 100.) + 1.);
	vec2  TexPos = vec2(DataParams.x, DataParams.y + Index * DataParams.z);
	vec3  Tex    = gltexture2D(WaveData, TexPos).rgb * 255.;

	return (Tex.r + Tex.g * 100.) * (Tex.b - 2.) / g_ScreenWid;
}

void Pgl_main()
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
    	gl_FragColor = v_vColour * gltexture2D(gm_BaseTexture, OutPos);
}

VS_OUTPUT Vmain(VS_INPUT input)
{
    in_Position = input._in_Position;
    in_Normal = input._in_Normal;
    in_Colour = input._in_Colour;
    in_TextureCoord = input._in_TextureCoord;

    Vgl_main();

    VS_OUTPUT output;
    output.gl_Position.x = gl_Position.x;
    output.gl_Position.y = gl_Position.y;
    output.gl_Position.z = gl_Position.z;
    output.gl_Position.w = gl_Position.w;
    output.v0 = v_vColour;
    output.v1 = v_vTexcoord;

    return output;
}

PS_OUTPUT Pmain(VS_OUTPUT input)
{
    v_vColour = input.v0;
    v_vTexcoord = input.v1.xy;

    Pgl_main();

    PS_OUTPUT output;
    output.gl_Color0 = gl_Color[0];
    return output;
}

technique _filter_glitchShader
{
    pass MainPass1
    {
        VertexShader = compile vs_3_0 Vmain();
        PixelShader  = compile ps_3_0 Pmain();
    }
}
