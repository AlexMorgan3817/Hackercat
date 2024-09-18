shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D displace : hint_anisotropy;
uniform float offset: hint_range(1.0, 64.0, 0.1);
vec2 rotate(vec2 v, float q)
{return vec2(v.x * cos(q) - v.y * sin(q), v.x * sin(q) + v.y * cos(q));}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 disp = texture(displace, uv);
	vec4 norm = texture(SCREEN_TEXTURE, uv);
	vec4 overlay = COLOR;
	float div = 3.0;

	if (uv.x > 0.49 && uv.x < .51 || (uv.y > 0.48 && uv.y < .52))
	{
		overlay = vec4(0.0,0,0,0); div = 2.0;
	}
	uv.x += disp.r * (1.0 - disp.b);
	uv.y += disp.g * (1.0 - disp.b);
	vec4 underlay = texture(SCREEN_TEXTURE, uv + vec2(0.0, offset/64.0));
	underlay.g += 0.1;
	COLOR = (underlay + norm + overlay)/div;
}
