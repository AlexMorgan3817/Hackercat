shader_type canvas_item;
render_mode unshaded;

uniform float MIX       : hint_range(0.0, 1.0, 0.1);
uniform float amt       : hint_range(0.0, 1.0, 0.1);
uniform float direction : hint_range(0.0, 1.0, 0.1);
uniform vec2 ScreenOffset = vec2(0, 0);
uniform sampler2D displace : hint_anisotropy;
uniform sampler2D subtractdisplace : hint_anisotropy;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment()
{
	vec4 disp = texture(displace, SCREEN_UV);
	vec4 subt = texture(subtractdisplace, SCREEN_UV);
	float d = disp.y * direction + disp.x * (direction-1.0);
	vec2 newUV = SCREEN_UV + ScreenOffset + d * amt;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * (1.0-MIX) + (texture(SCREEN_TEXTURE, newUV) - subt) * MIX;
}