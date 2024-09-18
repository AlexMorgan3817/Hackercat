shader_type canvas_item;
render_mode unshaded;

uniform float MIX       : hint_range(0.0, 1.0, 0.1);
uniform float amt       : hint_range(0.0, 1.0, 0.1);
uniform float direction : hint_range(0.0, 1.0, 0.1);
uniform vec2 ScreenOffset = vec2(0, 0);
uniform sampler2D displace : hint_anisotropy;
uniform float MixSubtract       : hint_range(0.0, 1.0, 0.1);
uniform sampler2D subtractdisplace : hint_anisotropy;
uniform float MixOverlay        : hint_range(0.0, 1.0, 0.1);
uniform sampler2D Overlay : hint_anisotropy;
uniform vec4 ColorOffset = vec4(0, 0, 0, 0);

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D mask_texture : hint_normal;
void fragment()
{	
	vec4 norm = texture(mask_texture, UV);
	float _mix = MIX * norm.a;
	vec4 disp = texture(displace, SCREEN_UV);
	vec4 subt = texture(subtractdisplace, SCREEN_UV);
	float d = disp.y * direction + disp.x * (direction-1.0);
	vec2 newUV = SCREEN_UV + ScreenOffset + d * amt;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * (1.0-_mix);
	COLOR += (texture(SCREEN_TEXTURE, newUV) - subt * MixSubtract) * _mix;
	vec4 col = texture(Overlay,SCREEN_UV);
	if (col.r==0.0 && col.g==0.0 && col.b==0.0) {
	    col.a=0.0;
	}
	COLOR += (col) * _mix * MixOverlay;
	COLOR += ColorOffset * norm.a;
}