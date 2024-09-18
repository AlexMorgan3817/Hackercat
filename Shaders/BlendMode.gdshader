shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float MixMultyply: hint_range(0.0, 1.0, 0.1);
uniform float MixAdd: hint_range(0.0, 1.0, 0.1);
//uniform float MixSubtract: hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 orig = COLOR;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = (COLOR * orig * MixMultyply);
	COLOR = COLOR + orig * MixAdd;
	//COLOR = COLOR - orig * MixSubtract;
}
