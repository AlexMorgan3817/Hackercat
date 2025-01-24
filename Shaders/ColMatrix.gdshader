shader_type canvas_item;
render_mode unshaded;

uniform mat3 mat_orig = mat3(1.0);
uniform mat3 mat_mod = mat3(1.0);
uniform float Mix: hint_range(0.0, 1.0, 0.1);

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec3 orig = vec3(COLOR.r, COLOR.g, COLOR.b);
	vec3 result = orig * (1.0-Mix) * mat_orig;
	result     += orig * Mix * mat_mod;
	COLOR.r = result.x;
	COLOR.g = result.y;
	COLOR.b = result.z;
}