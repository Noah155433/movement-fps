shader_type spatial;
render_mode depth_prepass_alpha;

uniform sampler2D albedo_texture;
uniform sampler2D noise_texture;

uniform float trans_amount;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float transition_amount = 0.1;
	ALBEDO = texture(albedo_texture, UV).xyz;
	
	float noise = texture(noise_texture, UV).x;
	float alpha = clamp(1.0 - (trans_amount * 2.0 - noise), 0.0, 1.0);
	alpha = pow(alpha * 2.0, 3);
	
	if (alpha < 1.2)
	{
		vec3 emissive_color = vec3(clamp(1.0 - alpha / 1.2, 0.2, 1.0), clamp(0.0 + alpha / 10.0, 0.0, 0.2), 0.0) * clamp(alpha, 0.0, 1.0);
		EMISSION = emissive_color;
	}
	
	ALPHA = clamp(alpha, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
