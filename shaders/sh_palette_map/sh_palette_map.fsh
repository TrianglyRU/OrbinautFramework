varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_indices[256];
uniform float u_bound;
uniform sampler2D u_texture_a;
uniform vec2 u_texel_a;
uniform vec3 u_uv_a;
uniform sampler2D u_texture_b;
uniform vec2 u_texel_b;
uniform vec3 u_uv_b;

vec4 getSwappedColour(vec4 src, sampler2D tex, vec2 texel, vec3 uv)
{
    float x = uv.x;
    float start = uv.y;
    float count = min(floor((uv.z - start) / texel.y), 256.0);
	
    for (int i = 0; i < 256; i++)
    {
        if (float(i) >= count)
        {
            break;
        }
		
        vec2 pos = vec2(x, start + float(i) * texel.y);
        vec4 key = texture2D(tex, pos);
		
        if (distance(key.rgb, src.rgb) < 0.001)
        {
            vec4 replacement = texture2D(tex, vec2(x + texel.x * floor(u_indices[i]), pos.y));
			
			if (replacement.a == 0.0)
			{
				return vec4(replacement.rgb, 0.0);
			}
			
            return vec4(replacement.rgb, src.a);
        }
    }
	
    return src;
}

void main()
{
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 swapped = (gl_FragCoord.y >= u_bound) ? getSwappedColour(base, u_texture_b, u_texel_b, u_uv_b) : getSwappedColour(base, u_texture_a, u_texel_a, u_uv_a);
    
    gl_FragColor = swapped * v_vColour;
}