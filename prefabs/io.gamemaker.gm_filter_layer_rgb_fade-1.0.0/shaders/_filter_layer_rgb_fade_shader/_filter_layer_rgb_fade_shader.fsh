const float LIMIT1 = 255.0;
const float LIMIT2 = 510.0;  // 2 * LIMIT1
const float LIMIT3 = 765.0;  // 3 * LIMIT1

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform int g_Type;
uniform float g_Timer;

vec3 applyFade(vec3 col)
{
    if (g_Type == 0)
    {
        return min(col - LIMIT3 + g_Timer + vec3(0.0, col.r, col.r + col.g), col);
    }
    else if (g_Type == 1)
    {
        return min(g_Timer - vec3(col.b + col.g, col.b, 0.0), col);
    }
    else if (g_Type == 2)
    {
        return min(col, g_Timer);
    }
    else if (g_Type == 3)
    {
        return max(col - max(LIMIT1 - g_Timer, 0.0), 0.0);
    }
    else if (g_Type == 4)
    {
        return max(vec3(LIMIT2 - col.b - col.g, LIMIT1 - col.b, 0.0) - g_Timer + LIMIT1, col);
    } 
    else if (g_Type == 5)
    {
        return max(col + LIMIT3 - g_Timer - vec3(0.0, LIMIT1 - col.r, LIMIT2 - col.r - col.g), col);
    } 
    else if (g_Type == 6) 
    {
        return max(col, LIMIT1 - g_Timer);
    } 
    else if (g_Type == 7) 
    {
        return min(col + max(LIMIT1 - g_Timer, 0.0), LIMIT1);
    }
    
    return col;
}

void main()
{
    vec4 baseColour = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    
    if (g_Type < 0)
    {
        gl_FragColor = baseColour;
    }
    else
    {
        gl_FragColor = vec4(applyFade(baseColour.rgb * 255.0) / 255.0, baseColour.a);
    }
}