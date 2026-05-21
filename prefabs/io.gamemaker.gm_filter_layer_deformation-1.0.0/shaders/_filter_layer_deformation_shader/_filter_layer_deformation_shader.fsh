#ifdef GL_ES
precision highp float;
#endif

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_Width;
uniform float g_Offset;
uniform float g_DataSizeA;
uniform float g_DataSizeB;
uniform float g_BoundUpper;    
uniform float g_BoundMiddle;
uniform float g_BoundLower;
uniform float g_DataA[256];
uniform float g_DataB[256];

void main()
{
    vec2 uv = v_vTexcoord;
    float y = gl_FragCoord.y;
    
    if (y >= g_BoundUpper && y <= g_BoundLower)
    {
        if (y < g_BoundMiddle)
        {
            uv.x -= g_DataA[int(mod(g_Offset + y, g_DataSizeA))] / g_Width;
        }
        else
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