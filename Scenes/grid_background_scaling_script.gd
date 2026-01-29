extends Control

@export var cell_size : Vector2 = Vector2(32, 32)
@export var grid_size : Vector2i = Vector2i(40, 30)
@export var zoom_rate : float = .02

@onready var shader : ShaderMaterial = material as ShaderMaterial

var mouse_button_wheel = [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]

func _on_mouse_entered() -> void:
	print("mouse entered grid")

func _gui_input(event) -> void:
	if event is InputEventMouseButton \
	and event.button_index in mouse_button_wheel \
	and event.pressed:
		var zoom_factor := 1.0 + zoom_rate
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_factor = 1.0 - zoom_rate

		var mouse := get_global_mouse_position()
		var offset := mouse - self.global_position
		var vp := get_viewport().get_visible_rect()
		var new_scale := self.scale * zoom_factor

		# ---- Predict rect AFTER zoom ----
		var new_pos := mouse - offset * zoom_factor
		var new_size := self.size * new_scale
		var predicted := Rect2(new_pos, new_size)

		# ---- Edge violations ----
		var left_violate   := predicted.position.x >= vp.position.x
		var top_violate    := predicted.position.y >= vp.position.y
		var right_violate  := predicted.end.x <= vp.end.x
		var bottom_violate := predicted.end.y <= vp.end.y

		# ---- Opposite-edge rejection ----
		if (left_violate and right_violate) or (top_violate and bottom_violate):
			return

		# ---- Pin violating edges ----
		if left_violate:
			new_pos.x = vp.position.x
		elif right_violate:
			new_pos.x = vp.end.x - new_size.x

		if top_violate:
			new_pos.y = vp.position.y
		elif bottom_violate:
			new_pos.y = vp.end.y - new_size.y

		# ---- Commit ----
		self.scale = new_scale
		self.global_position = new_pos
		
	if event is InputEventPanGesture and not is_zero_approx(event.delta.y):
		pan_gestrue_to_scroll(event.delta.y)


func pan_gestrue_to_scroll(delta: float) -> void:
	var mouse := get_global_mouse_position()
	var factor := 1.0 + delta * zoom_rate
	var vp := get_viewport().get_visible_rect()
	var offset := mouse - self.global_position
	var new_scale := self.scale * factor

	# ---- Predict rect AFTER zoom ----
	var new_pos := mouse - offset * factor
	var new_size := self.size * new_scale
	var predicted := Rect2(new_pos, new_size)

	# ---- Edge violations ----
	var left_violate   := predicted.position.x >= vp.position.x
	var top_violate    := predicted.position.y >= vp.position.y
	var right_violate  := predicted.end.x <= vp.end.x
	var bottom_violate := predicted.end.y <= vp.end.y

	# ---- Opposite-edge rejection ----
	if (left_violate and right_violate) or (top_violate and bottom_violate):
		return

	# ---- Pin violating edges ----
	if left_violate:
		new_pos.x = vp.position.x
	elif right_violate:
		new_pos.x = vp.end.x - new_size.x

	if top_violate:
		new_pos.y = vp.position.y
	elif bottom_violate:
		new_pos.y = vp.end.y - new_size.y

	# ---- Commit ----
	self.scale = new_scale
	self.global_position = new_pos
