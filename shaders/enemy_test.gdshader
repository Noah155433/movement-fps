shader_type spatial;

uniform sampler2D albedo_texture : source_color;
uniform bool bilinear;
uniform vec2 uv_size;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ivec2 texture_size = textureSize(albedo_texture, 0);
	ivec2 texture_space_uv = ivec2(UV * uv_size * vec2(texture_size)) % texture_size;
	
	
	//ALBEDO = texelFetch(albedo_texture, ivec2(UV * vec2(size)), 0).xyz;
	ALBEDO = texelFetch(albedo_texture, texture_space_uv, 0).xyz;
}

void light() {
	float diffuse = dot(NORMAL, LIGHT) * ATTENUATION;
	diffuse = (diffuse < 0.3) ? 0.0 : ((diffuse < 0.6) ? 0.3 : 0.7);
	
	DIFFUSE_LIGHT = diffuse * (LIGHT_COLOR / PI);
}
