extends ColorRect

@export var cell_size : Vector2 = Vector2(32, 32)
@export var grid_size : Vector2i = Vector2i(40, 30)
@export var zoom_rate : float = .01

@onready var shader : ShaderMaterial = material as ShaderMaterial

func _on_mouse_entered() -> void:
	print("mouse entered grid")

func _gui_input(event) -> void:
	#if event is InputEventMouseButton and event.pressed:
		#self.pivot_offset = get_local_mouse_position()
	if event is InputEventMouseButton and event.pressed:
		if event.button_index not in [
			MOUSE_BUTTON_WHEEL_UP,
			MOUSE_BUTTON_WHEEL_DOWN
		]:
			return

		var zoom_factor := 1.0 + zoom_rate
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_factor = 1.0 - zoom_rate

		var old_scale := scale
		var mouse_global := get_global_mouse_position()

		# Vector from control origin to mouse
		var to_mouse := mouse_global - global_position

		# Apply scale
		scale *= Vector2(zoom_factor, zoom_factor)

		# Compensate position so mouse stays fixed
		global_position = mouse_global - to_mouse * (scale.x / old_scale.x)
#################################################
		#var zoom_step := Vector2(zoom_rate, zoom_rate)
		#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#zoom_step = -zoom_step
		#var new_scale := scale + zoom_step
		#new_scale = new_scale.clamp(Vector2(0.58, 0.58), Vector2(20.0, 20.0)) # Optional hard clamp
#
		## ---- Predict global rect AFTER scaling ----
		#var local_rect := Rect2(Vector2.ZERO, size)
		#var scaled_size := local_rect.size * new_scale
		#var pivot_shift := self.pivot_offset * (new_scale - scale) # pivot_offset shifts origin when scaling
		#var predicted_position := self.global_position - pivot_shift
		#var predicted_rect := Rect2(predicted_position, scaled_size)
		## ---- Constraint check ----
		#var viewport_rect := get_viewport().get_visible_rect()
		#var invalid := (
			#predicted_rect.position.x > viewport_rect.position.x or
			#predicted_rect.position.y > viewport_rect.position.y or
			#predicted_rect.end.x < viewport_rect.end.x or
			#predicted_rect.end.y < viewport_rect.end.y
		#)
		#if not invalid:
			#self.scale = new_scale
#####################################################################
		print("scale  -", self.scale)

			
			
	#if event is InputEventMouseButton:
		#self.pivot_offset = get_local_mouse_position()
		#var grid_rect = self.get_rect()
		#print("self.rect", self.get_rect())
		#print("self.pivot_offset", self.pivot_offset)
#
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			#if grid_rect.position.x < 0 and grid_rect.position.y < 0 and position.x + size.x > 100 and position.y + size.y > 100:
				#self.scale += Vector2(zoom_rate, zoom_rate)
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			#if grid_rect.position.x < 0 and grid_rect.position.y < 0 and position.x + size.x > 100 and position.y + size.y > 100:
				#self.scale -= Vector2(zoom_rate, zoom_rate)
	if event is InputEventPanGesture and not is_zero_approx(event.delta.y):
		pan_gestrue_to_scroll(event.delta.y)


func pan_gestrue_to_scroll(delta : float) -> void:
	var local_mouse := get_local_mouse_position()
	var uv := local_mouse / size
	print("mouse_uv", uv)
	shader.set_shader_parameter("mouse_uv", uv)
	
	var zoom : float = shader.get_shader_parameter("zoom") + delta * 0.5
	shader.set_shader_parameter("zoom", clamp(zoom, 1.0, 50.0))
