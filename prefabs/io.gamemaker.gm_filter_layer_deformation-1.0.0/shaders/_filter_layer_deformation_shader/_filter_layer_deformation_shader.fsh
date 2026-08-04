#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 g_ContextRect;
uniform float g_Offset;
uniform float g_Width;
uniform float g_DataSizeA;
uniform float g_DataSizeB;
uniform float g_DataA[256];
uniform float g_DataB[256];

float getContext()
{
    vec2 p = gl_FragCoord.xy;
    return step(g_ContextRect.x, p.x) * step(g_ContextRect.y, p.y) * step(p.x, g_ContextRect.z) * step(p.y, g_ContextRect.w);
}

void main()
{
    vec2 uv = v_vTexcoord;
    float y = gl_FragCoord.y;
    
    if (getContext() < 0.5)
    {
        if (g_DataSizeA > 0.0)
        {
            uv.x -= g_DataA[int(mod(g_Offset + y, g_DataSizeA))] / g_Width;
        }
    }
    else
    {
        if (g_DataSizeB > 0.0)
        {
            uv.x -= g_DataB[int(mod(g_Offset + y, g_DataSizeB))] / g_Width;
        }
    }
    
    if (uv.x < 0.0 || uv.x > 1.0)
    {
        gl_FragColor = vec4(0.0);
    }
    else
    {
        gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
    }
}