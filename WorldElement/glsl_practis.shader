shader_type canvas_item;

float rand(vec2 coord){
	coord = mod(coord, 1000.0);
	return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 436758.5453);
}

vec2 rand2(vec2 coord){
	coord = mod(coord, 1000.0);
	return fract(sin( vec2(dot(coord, vec2(127.1, 311.7)), dot(coord, vec2(269.5, 183.3))) ) * 438758.5453);
}

float value_noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float tl = rand(i);
	float tr = rand(i + vec2(1.0, 0.0));
	float bl = rand(i + vec2(0.0, 1.0));
	float br = rand(i + vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	float topmix = mix(tl, tr, cubic.x);
	float botmix = mix(bl, br, cubic.x);
	float wholemix = mix(topmix, botmix, cubic.y);
	
	return wholemix;
}

float perlin_noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float tl = rand(i) * 6.283; 
	float tr = rand(i + vec2(1.0, 0.0)) * 6.283;
	float bl = rand(i + vec2(0.0, 1.0)) * 6.283;
	float br = rand(i + vec2(1.0, 1.0)) * 6.283;
	
	vec2 tlvec = vec2( -sin(tl) ,  cos(tl) );
	vec2 trvec = vec2( -sin(tr) ,  cos(tr) );
	vec2 blvec = vec2( -sin(bl) ,  cos(bl) );
	vec2 brvec = vec2( -sin(br) ,  cos(br) );
	
	float tldot = dot(tlvec, f);
	float trdot = dot(trvec, f - vec2(1.0, 0.0));
	float bldot = dot(blvec, f - vec2(0.0, 1.0));
	float brdot = dot(brvec, f - vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	float topmix = mix(tldot, trdot, cubic.x);
	float botmix = mix(bldot, brdot, cubic.x);
	float wholemix = mix(topmix, botmix, cubic.y);
	
	return wholemix + 0.5;
}

void fragment(){
	vec2 coord = UV * 50.0 ;
//	coord = mod(coord, 1.0);
	float value = perlin_noise(coord);
	
	COLOR = vec4(vec3(value),1.0);
}