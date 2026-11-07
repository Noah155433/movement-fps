shader_type spatial;

uniform sampler2D noise_small;
uniform sampler2D displacement;

uniform float specular : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float roughness : hint_range(0.0, 1.0, 0.1) = 0.2;
uniform float normal_strength : hint_range(0.0, 1.0, 0.1) = 1.0;

uniform vec2 uv_scale = vec2(1.0);

void vertex() {
	VERTEX = vec3(VERTEX.x, VERTEX.y + texture(displacement, UV).r, VERTEX.z);
}

float fresnel(float amount, vec3 normal, vec3 view){
	return pow(
		1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0),
		amount
	);
}

void fragment() {
	
	vec2 uv = UV * uv_scale;
	
	float fresnel = fresnel(3.0, NORMAL, VIEW);
	
	vec3 normal = texture(noise_small, uv).rgb;
	NORMAL_MAP = normal;
	NORMAL_MAP_DEPTH = normal_strength;
	
	SPECULAR = specular * fresnel;
	ROUGHNESS = roughness;
	
	ALBEDO = vec3(0.015, 0.04, 0.055) * fresnel;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
