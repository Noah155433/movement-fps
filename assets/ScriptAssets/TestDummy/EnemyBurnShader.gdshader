shader_type spatial;
render_mode blend_mix,
	cull_disabled,
	depth_prepass_alpha,
	shadows_disabled,
	specular_disabled,
	vertex_lighting;


uniform sampler2D albedo;
uniform vec4 albedo_color : source_color = vec4(1.0);

uniform sampler2D emission;
uniform vec4 emission_color : source_color = vec4(0.0);

uniform vec2 texture_size = vec2(1.0);
uniform float alpha_scissor : hint_range(0.0, 1.0) = 1.0;


void vertex() {
	vec4 clip_pos = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	
	vec3 ndc = clip_pos.xyz / clip_pos.w;
	
	ndc.xy = floor(ndc.xy * 100.0) / 100.0;
	
	clip_pos.xyz = ndc * clip_pos.w;
	
	POSITION = clip_pos;
	
	UV.x *= (1.0 + (VERTEX.z * -2.0));
	UV.y *= (1.0 + (VERTEX.z * -2.0));
	
}

void fragment() {
	
	vec2 uv = UV;
	uv.x /= (1.0 + (VERTEX.z * -2.0));
	uv.y /= (1.0 + (VERTEX.z * -2.0));
	
	uv /= texture_size;
	
	ALBEDO = albedo_color.rgb * texture(albedo, uv).rgb;
	
	ALPHA = texture(albedo, uv).a;
	ALPHA_SCISSOR_THRESHOLD = alpha_scissor;
	
	EMISSION = emission_color.rgb * texture(emission, uv).rgb;
	
}
