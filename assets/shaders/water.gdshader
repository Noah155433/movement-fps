shader_type spatial;

uniform sampler2D reflect_texture;

void vertex() {
	
}

void fragment() {
	ALBEDO = texture(reflect_texture, UV).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
