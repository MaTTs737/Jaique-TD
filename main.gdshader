shader_type canvas_item;

uniform float fog_intensity : hint_range(0.0, 1.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	base_color.a *= fog_intensity;
	COLOR = base_color;// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
