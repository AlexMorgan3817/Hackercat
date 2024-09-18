shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float offset: hint_range(-1.0, 1.0, 0.01);
uniform float Arg: hint_range(-0.1, 0.1, 0.001);
uniform float Mix: hint_range(0, 1, 0.01);

uniform sampler2D DisplaceTexture : hint_normal;

void fragment() {
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 nUV = SCREEN_UV;
	if((col.r + col.g + col.b)/3.0 < 1.0)
	{
		vec4 ocol = texture(DisplaceTexture, UV);
		nUV.x += (ocol.x + offset) * Arg;
		vec4 rescol = texture(SCREEN_TEXTURE, nUV);
		COLOR = COLOR * rescol * Mix;
	}
}
