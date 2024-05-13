shader_type canvas_item;

uniform sampler2D dissolve_pattern;
uniform float disolve_state : hint_range(0, 1.1) = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float pattern_val = texture(dissolve_pattern, UV).r;
	COLOR.rgb = vec3(0);
	COLOR.a *= step(disolve_state, pattern_val);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
