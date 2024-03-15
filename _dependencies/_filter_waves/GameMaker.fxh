// Compatibility stuff:

#define vec4 float4
#define vec3 float3
#define vec2 float2
#define mat4 float4x4
#define mix lerp
#define fract frac
#define gl_FragColor gl_Color[0]
#define gl_FragCoord gl_Position
#define attribute static
#define varying static

uniform sampler2D gm_BaseTexture : register(s0) /* = sampler_state { Texture = (gm_BaseTextureSkeleton); }*/ ;
uniform mat4 MVPTransform : register(c0); // IDE only, the world projection matrix.

struct VS_INPUT
{
    vec3 _in_Position : POSITION;
    vec3 _in_Normal : NORMAL0;
    vec4 _in_Colour : COLOR0;
    vec2 _in_TextureCoord : TEXCOORD0;
};

struct VS_OUTPUT
{
    vec4 gl_Position : POSITION;
    vec4 v0 : TEXCOORD0;
    vec2 v1 : TEXCOORD1;
};

struct PS_OUTPUT
{
    vec4 gl_Color0 : COLOR0;
    // GLSL ES only has one render target, as such we only return one color.
    // add more colors if you wish to support MRT here...
};

// a wrapper around texture2D() that can be used in for() loops.
vec4 gltexture2D(sampler2D _s, vec2 _uv)
{
    return tex2Dlod(_s, vec4(_uv, 0.0, 0.0));
}

float mod(float v1, float v2)
{
    return (v1 % v2);
}
