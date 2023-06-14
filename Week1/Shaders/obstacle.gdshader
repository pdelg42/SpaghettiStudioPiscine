shader_type canvas_item;

uniform vec2 direction = vec2(1, 0);
uniform float speed = 0.1;
uniform sampler2D noise;

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.9, base);
	return mix(2. * base * blend, 1.0 - (1.0 - base) * (1.0 - blend), limit);
}

void fragment()
{
	// image texture
	vec4 base = texture(TEXTURE, UV);
	// noise texture
	float std_clr = base.r;
	if (base.r < .60)
		base.r = abs(sin(TIME)) * 0.25 + std_clr;
		
	vec4 blend = texture(noise, UV);
	
	
	COLOR = overlay(base, blend);
}