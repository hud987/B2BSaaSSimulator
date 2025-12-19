shader_type canvas_item;

uniform vec2 resolution = vec2(600.0,400.0);
uniform vec3 line_color : source_color = vec3(1.0,1.0,1.0);
uniform float zoom : hint_range(1.0, 50.0, 0.1) = 20.0;
uniform float thickness : hint_range(0.0, 10.0, 0.1) = 2.0;
uniform float brightness : hint_range(0.0, 4.0, 0.1) = 2.0;
uniform vec2 mouse_uv = vec2(1.0,1.0);

float draw_grid(vec2 uv) {
	vec2 grid_uv = cos(uv);
	return max(grid_uv.x, grid_uv.y);
}
	
void fragment() {
    // 1. aspect ratio correction
    vec2 uv = UV;
    uv.x *= resolution.x / resolution.y;

    // 2. zoom around mouse
    vec2 mouse = mouse_uv;
    mouse.x *= resolution.x / resolution.y; // scale mouse same as UV
    uv = (uv - mouse) * zoom + mouse;

    // 3. draw grid
    float line_thickness = zoom * thickness / resolution.y;
    vec3 color = step(0.998, draw_grid(uv)) * line_color;
    COLOR = vec4(color * brightness, 1.0);
}