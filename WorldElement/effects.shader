shader_type canvas_item;

uniform int effect = 0;
uniform float blur = 1.0;
uniform vec2 offset = vec2( 0.005, 0.005 );
uniform vec2 resulation = vec2( 600, 600 );
uniform int pixel_size = 6;
//uniform vec4 color : hint_color;

void fragment(){
	if (effect == 0){
		
	} else if  (effect == 1){
		vec4 screen = texture(SCREEN_TEXTURE, SCREEN_UV, blur);
		COLOR = screen;
		
	} else if (effect == 2){
		float color_r = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + offset.x, SCREEN_UV.y - offset.y), 0.0).r;
//		float color_g = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - offset.x, SCREEN_UV.y + offset.y), 0.0).g;
		float color_b = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - offset.x, SCREEN_UV.y + offset.y), 0.0).b;

		COLOR = vec4(color_r, 0.1, color_b, 1.0);
		
	} else if (effect == 3){
		int uv_x = int(floor(SCREEN_UV.x * resulation.x)) - int(floor(SCREEN_UV.x * resulation.x)) % pixel_size;
		int uv_y = int(floor(SCREEN_UV.y * resulation.y)) - int(floor(SCREEN_UV.y * resulation.y)) % pixel_size;

		vec4 screen = texture(SCREEN_TEXTURE, vec2(float(uv_x) / resulation.x, float(uv_y) / resulation.y), 0.0);
		COLOR = screen;
		
	} else if (effect == 4) {
		int uv_x = int(SCREEN_UV.x * resulation.x) + int(SCREEN_UV.x * resulation.x) % pixel_size;
		int uv_y = int(SCREEN_UV.y * resulation.y) + int(SCREEN_UV.y * resulation.y) % pixel_size;

		vec4 screen = texture(SCREEN_TEXTURE, vec2(float(uv_x) / resulation.x, float(uv_y) / resulation.y), 0.0);
		COLOR = screen;
	} else if (effect == 5) {
		
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV, sin(SCREEN_UV.x * 500.0) + 1.0);
	} else if (effect == 6){
		float color_r = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + offset.x, SCREEN_UV.y - offset.y), 0.0).r;
		float color_g = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - offset.x, SCREEN_UV.y + offset.y), 0.0).g;
		float color_b = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - offset.x, SCREEN_UV.y + offset.y), 0.0).b;

		COLOR = vec4(color_r, color_g * 0.5, color_b, 1.0);
		
	}
}