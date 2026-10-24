shader_type spatial;

uniform sampler2D albedo_texture : source_color;
uniform bool bilinear;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = texture(albedo_texture, UV).xyz;
}

void light() {
	float diffuse = dot(NORMAL, LIGHT) * ATTENUATION;
	diffuse = (diffuse < 0.3) ? 0.0 : ((diffuse < 0.6) ? 0.3 : 0.7);
	
	DIFFUSE_LIGHT = diffuse * (LIGHT_COLOR / PI);
}
