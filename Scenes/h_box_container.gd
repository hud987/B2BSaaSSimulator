extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mouse_entered(event):
	print(event)

#func _input(event: InputEvent):
	##print(event)
	#print(mouse_entered)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		print("HBox1 Pressed")
