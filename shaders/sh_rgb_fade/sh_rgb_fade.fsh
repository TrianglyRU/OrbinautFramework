const float LIMIT1 = 255.0;
const float LIMIT2 = 510.0;  // 2 * LIMIT1
const float LIMIT3 = 765.0;  // 3 * LIMIT1

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform int u_type;
uniform float u_timer;

vec3 applyFade(vec3 col)
{
    if (u_type == 0)
    {
        return min(col - LIMIT3 + u_timer + vec3(0.0, col.r, col.r + col.g), col);
    }
    else if (u_type == 1)
    {
        return min(u_timer - vec3(col.b + col.g, col.b, 0.0), col);
    }
    else if (u_type == 2)
    {
        return min(col, u_timer);
    }
    else if (u_type == 3)
    {
        return max(col - max(LIMIT1 - u_timer, 0.0), 0.0);
    }
    else if (u_type == 4)
    {
        return max(vec3(LIMIT2 - col.b - col.g, LIMIT1 - col.b, 0.0) - u_timer + LIMIT1, col);
    } 
    else if (u_type == 5)
    {
        return max(col + LIMIT3 - u_timer - vec3(0.0, LIMIT1 - col.r, LIMIT2 - col.r - col.g), col);
    } 
    else if (u_type == 6) 
    {
        return max(col, LIMIT1 - u_timer);
    } 
    else if (u_type == 7) 
    {
        return min(col + max(LIMIT1 - u_timer, 0.0), LIMIT1);
    }
    
    return col;
}

void main()
{
    vec4 baseColour = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    
    if (u_type < 0)
    {
        gl_FragColor = baseColour;
    }
    else
    {
        gl_FragColor = vec4(applyFade(baseColour.rgb * 255.0) / 255.0, baseColour.a);
    }
}