shader_type canvas_item;
render_mode unshaded;

uniform float MIX: hint_range(0.0, 1.0, 0.1);
uniform sampler2D displace : hint_anisotropy;
uniform float displaysmentAmount: hint_range(0.0, 1.0, 0.001);
uniform vec4 colorChange;

uniform float AbberationMix: hint_range(0.0, 1.0, 0.001);
uniform float AbbreationAmt: hint_range(0.0, 0.1);

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment()
{
	vec4 disp = texture(displace, SCREEN_UV);
	vec2 newUV = (SCREEN_UV + disp.x * displaysmentAmount * COLOR.b);
	COLOR = COLOR + (colorChange + texture(TEXTURE, newUV))* MIX;
	
	COLOR.r = COLOR.r + texture(TEXTURE, newUV - AbbreationAmt).r * AbberationMix;
	COLOR.g = COLOR.g + texture(TEXTURE, newUV).g * AbberationMix;
	COLOR.b = COLOR.b + texture(TEXTURE, newUV - AbbreationAmt).b * AbberationMix;
}
