shader_type canvas_item;

uniform float t:hint_range(0.0, 1.0, 0.1);

void fragment()
{
	COLOR = COLOR * t;
}
