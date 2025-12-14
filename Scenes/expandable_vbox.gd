extends VBoxContainer

@export var is_expanded : bool = true
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType

func _on_button_pressed() -> void:
	self.expand()

func expand() -> void:
	if is_expanded:
		set_tween("scale", Vector2(1,0), time)
	else:
		set_tween("scale", Vector2(1,1), time)
	is_expanded = !is_expanded

func set_tween(property: String, val: Variant, duration: float) -> void:
	get_tree().create_tween().tween_property(self, property, val, duration).set_trans(transition_type)
