extends Node2D

var dragging := false
var drag_offset := Vector2.ZERO
@onready var sprite: Polygon2D = $Sprite2D
var lambda_rectangle_size = Vector2(100,100)
var is_mouse_button_down = false

func _input(event):
	if is_mouse_over():
		#print("mouse over lambda ", event)
		handle_mouse_drag(event)

func handle_mouse_drag(event):
	print("handle_mouse_drag")
	print("is_mouse_button_down ", is_mouse_button_down)
	#if event is InputEventMouseButton and event.button_mask == 1:
		#is_mouse_button_down = true
		
	if event is InputEventMouseMotion and event.button_mask == 1:
		self.global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		is_mouse_button_down = false
		
		#if is_mouse_on_screen():
			#tempLambda.global_position = camera_2d.get_global_mouse_position()
			#print("placed lambda at: ", camera_2d.get_global_mouse_position())
			#print("event: ", event)
			


func is_mouse_over() -> bool:
	var mouse_local = sprite.to_local(get_global_mouse_position())
	var rect = Rect2(-lambda_rectangle_size / 2, lambda_rectangle_size)
	return rect.has_point(mouse_local)

#func is_mouse_on_screen() -> bool:
	#var mouse_position_relative_to_screen = get_global_mouse_position()
	#var mouse_is_off_screen = mouse_position_relative_to_screen.x < get_viewport().size.x \
	#and mouse_position_relative_to_screen.y < get_viewport().size.y \
	#and mouse_position_relative_to_screen.x > 0 \
	#and mouse_position_relative_to_screen.y > 0
	#return mouse_is_off_screen
