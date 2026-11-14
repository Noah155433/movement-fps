shader_type spatial;

const int x = 40;
const int y = 30;

uniform int msg[x * y];
uniform sampler2D bitmap;

void vertex() {
	
}

void fragment() {
	ivec2 pixel = ivec2(UV * vec2(float(x * 10), float(y * 10)));
	ivec2 sub_pixel = ivec2(pixel.x % 10, pixel.y % 10);
	ivec2 index = ivec2(pixel.x / 10, (pixel.y) / 10);
	int char = msg[index.y * x + index.x];
	ivec2 tex_index = ivec2((char % 16) * 10 + sub_pixel.x, char / 16 * 10 + sub_pixel.y);
	float color = texelFetch(bitmap, tex_index, 0).r;
	
	ALBEDO = vec3(color);
}
