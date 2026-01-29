extends Control
	
@export var is_expanded : bool = true
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType
@onready var resourcesGridContainer : GridContainer = self.get_child(0)

#@onready var button: Button = %CollapseTestButton
#@onready var collapse_control: Control = %CollapseControl

#Setting this node to "Clip Contents = True" is key
#Force the initial render to be correct
func _ready() -> void:
	await get_tree().process_frame #Can force dropdown to render closed
	custom_minimum_size.y = resourcesGridContainer.size.y + 7
	self.size.y = custom_minimum_size.y if is_expanded else 0.0


func expand() -> void:
	print("custom_minimum_size.y: ", custom_minimum_size.y)
	if is_expanded:
		set_tween("custom_minimum_size:y", 0, time)
	else:
		set_tween("custom_minimum_size:y", resourcesGridContainer.size.y + 7, time)
	is_expanded = !is_expanded

func set_tween(property: String, val: Variant, duration: float) -> void:
	create_tween().tween_property(self, property, val, duration).set_trans(transition_type)

func _on_compute_button_pressed() -> void:
	self.expand()

func _on_storage_button_pressed():
	self.expand()
