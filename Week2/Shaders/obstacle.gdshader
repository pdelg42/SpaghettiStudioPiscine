shader_type canvas_item;

uniform vec2 direction = vec2(1, 0);
uniform float speed = 0.1;
uniform sampler2D noise;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}

void vertex() {
    VERTEX = rotateUV(VERTEX, TEXTURE_PIXEL_SIZE, TIME * speed);
}

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.9, base);
	return mix(1.5 * base, 1. - (1.0 - blend) * (1.0 - base), limit);
}

bool not_in_circle(vec2 point, vec2 center){
	float radius = 0.1;
	if (point.x > radius)
		return true;
	return false;
}

void fragment()
{
	// image texture
	if (not_in_circle(POINT_COORD, TEXTURE_PIXEL_SIZE))
		COLOR = vec4(0, 0, 0, 0);
	else {
		vec4 base = texture(TEXTURE, UV);
		// noise texture
		float std_clr = base.r;
		if (base.r < .60)
			base.r = abs(sin(TIME)) * 0.25 + std_clr;
			
		vec4 blend = texture(noise, UV);
		
		COLOR = overlay(base, blend);
	}
}