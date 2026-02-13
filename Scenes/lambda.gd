extends Panel

@onready var lambda = preload("res://Resources/Lambda.tscn")
@onready var grid_background : Control = %GridBackground
@onready var menu_background : Control = %MenuBackground
@onready var menu_background_default_child_count = menu_background.get_child_count()

func _on_gui_input(event):
	print("event: ", event)
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
			
		if event.global_position.x > 354:
			grid_background.add_child(tempLambda)
			tempLambda.global_position = event.global_position
			
	else:
		if menu_background.get_child_count() > menu_background_default_child_count:
			menu_background.get_child(menu_background_default_child_count).queue_free()
