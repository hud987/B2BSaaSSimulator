extends Panel

@onready var lambda = preload("res://Resources/Lambda.tscn")
var currTile

func _on_gui_input(event):
	var tempLambda = lambda.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempLambda)
		tempLambda.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		if event.global_position.x <= 354:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
				
			var grid = get_tree().get_root().get_node("B2BSaaSSimulator/Grid")
			grid.add_child(tempLambda)
			tempLambda.global_position = event.global_position
		
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
