extends GridContainer
	
@export var is_expanded : bool = true
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType

#Force the initial render to be correct
func _ready() -> void:
	await get_tree().process_frame #Can force dropdown to render closed
	scale.y = 1.0 if is_expanded else 0.0

func _on_button_pressed() -> void:
	print(self.scale)
	self.expand()

func expand() -> void:
	if is_expanded:
		set_tween("scale", Vector2(1,0), time)
	else:
		set_tween("scale", Vector2(1,1), time)
	is_expanded = !is_expanded

func set_tween(property: String, val: Variant, duration: float) -> void:
	get_tree().create_tween().tween_property(self, property, val, duration).set_trans(transition_type)
