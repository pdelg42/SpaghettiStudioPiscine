shader_type canvas_item;

uniform float speed = 0;

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
    VERTEX = rotateUV(VERTEX, 0.5 * vec2(64.,  64.) , speed);
}
