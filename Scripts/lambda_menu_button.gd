extends Panel

@onready var lambda = preload("res://Resources/lambda.tscn")
@onready var grid_background : Control = %GridBackground
@onready var menu_background : Control = %MenuBackground
@onready var camera_2d : Camera2D = %Camera2D
@onready var menu_background_default_child_count = menu_background.get_child_count()

func _on_gui_input(event):
	handle_mouse_drag(event)

func handle_mouse_drag(event):
	var tempLambda = lambda.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		menu_background.add_child(tempLambda)
		tempLambda.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if menu_background.get_child_count() > menu_background_default_child_count:
			menu_background.get_child(menu_background_default_child_count).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		if menu_background.get_child_count() > menu_background_default_child_count:
			menu_background.get_child(menu_background_default_child_count).queue_free()
		
		if is_mouse_on_screen():
			grid_background.add_child(tempLambda)
			tempLambda.global_position = camera_2d.get_global_mouse_position()
			print("placed lambda at: ", camera_2d.get_global_mouse_position())
			print("event: ", event)
			
	else:
		if menu_background.get_child_count() > menu_background_default_child_count:
			menu_background.get_child(menu_background_default_child_count).queue_free()

func is_mouse_on_screen() -> bool:
	var mouse_position_relative_to_screen = get_global_mouse_position()
	var mouse_is_off_screen = mouse_position_relative_to_screen.x < get_viewport().size.x \
	and mouse_position_relative_to_screen.y < get_viewport().size.y \
	and mouse_position_relative_to_screen.x > 0 \
	and mouse_position_relative_to_screen.y > 0
	return mouse_is_off_screen
