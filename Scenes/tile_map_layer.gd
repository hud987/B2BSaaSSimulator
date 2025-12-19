extends ColorRect

@export var cell_size : Vector2 = Vector2(32, 32)
@export var grid_size : Vector2i = Vector2i(40, 30)

@onready var shader : ShaderMaterial = material as ShaderMaterial

func _on_mouse_entered() -> void:
	print("mouse entered grid")

func _gui_input(event) -> void:
	if event is InputEventPanGesture and not is_zero_approx(event.delta.y):
		handle_scroll(event.delta.y)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			print("Wheel up")

func handle_scroll(delta : float) -> void:
	var local_mouse := get_local_mouse_position()
	var uv := local_mouse / size
	shader.set_shader_parameter("mouse_uv", uv)
	
	var zoom : float = shader.get_shader_parameter("zoom") + delta * 0.5
	shader.set_shader_parameter("zoom", clamp(zoom, 1.0, 50.0))
