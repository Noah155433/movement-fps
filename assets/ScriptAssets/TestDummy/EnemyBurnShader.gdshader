shader_type spatial;
render_mode depth_prepass_alpha, vertex_lighting;

uniform sampler2D albedo_texture;
uniform sampler2D noise_texture;

uniform float trans_amount;

void vertex() {
    vec4 clip_pos = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);

    vec3 ndc = clip_pos.xyz / clip_pos.w;

    ndc.xy = floor(ndc.xy * 100.0) / 100.0;

    clip_pos.xyz = ndc * clip_pos.w;

    POSITION = clip_pos;
}

void fragment() {
	
	float transition_amount = 0.1;
	ALBEDO = texture(albedo_texture, UV).xyz;
	
	float noise = texture(noise_texture, UV).x;
	float alpha = clamp(1.0 - (trans_amount * 2.0 - noise), 0.0, 1.0);
	alpha = pow(alpha * 2.0, 3);
	
	if (alpha < 1.5)
	{
		vec3 emissive_color = mix(vec3(2.0, 0.0, 0.0), vec3(2.0, 0.3, 0.0), clamp(alpha - 0.5, 0.0, 1.0)) * ((alpha > 1.0) ? clamp(1.5 - alpha, 0.0, 1.0) : clamp(alpha, 0.0, 1.0));
		EMISSION = emissive_color;
	}
	
	ALPHA = clamp(alpha, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
