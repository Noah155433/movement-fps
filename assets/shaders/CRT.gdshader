shader_type spatial;
render_mode unshaded, fog_disabled;

const int x = 40;
const int y = 30;

uniform int msg[x * y];
uniform sampler2D bitmap;

void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	ivec2 pixel = ivec2(UV * vec2(float(x * 10), float(y * 10)));
	ivec2 sub_pixel = ivec2(pixel.x % 10, y - pixel.y % 10);
	ivec2 index = ivec2(pixel.x / 10, (y * 10 - pixel.y) / 10);
	int char = msg[index.y * x + index.x];
	bool on = texelFetch(bitmap, ivec2((char % 16) * 10 + sub_pixel.x, char / 16 * 10 + sub_pixel.y - 20), 0).r > 0.5;
	
	ALBEDO = vec3(float(on) * 1.0);
}
