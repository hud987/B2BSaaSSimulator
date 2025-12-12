extends VBoxContainer

@export var is_expanded = true
@export var from_center : bool = false
@export var hover_scale : Vector2 = Vector2(1,1)
@export var transition_type : Tween.TransitionType

enum STATE {OPEN,CLOSED,OPENING,CLOSING}

var init = false
var state :STATE
var max_size : Vector2i
var last_size : Vector2i

@onready var v_box = $"."

func _ready():
	state = STATE.OPEN

func _on_button_pressed():
	print("_on_button_pressed")
	self.expand()

func expand():
	print("is_expanded: ", is_expanded)
	is_expanded = !is_expanded
	if is_expanded:
		state = STATE.OPENING
		v_box.scale.y = 1
		state = STATE.OPEN
		#control_node.custom_minimum_size.y = top_inputs_container.size.y
	else:
		state = STATE.CLOSING
		#control_node.custom_minimum_size.y = collapse_button/button_container.custom_minimum_size.y
		v_box.scale.y = 0
		state = STATE.CLOSED
	print("state: ", state)
	
func add_tween(property: STring, value: any, seconds: float) -> void:
		var tween = get_tree().create_tween()
		tween.tween_property(target, property, value, seconds).set_trans(transition_type)

#func _process(delta):
	#if not init:
		#print("process init")
		#print("max_size: ", max_size)
		#max_size = v_box.size
		#last_size = v_box.size
		#v_box.custom_minimum_size.y = max_size.y
		#init = true
	#
	#if state == STATE.CLOSING:
		#v_box.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		#print("process closing")
		#if v_box.custom_minimum_size.y > 0:
			#v_box.custom_minimum_size.y = lerp(last_size.y,0,0.1)
			#last_size = v_box.custom_minimum_size
			#print("last_size: ", last_size)
		#elif v_box.custom_minimum_size.y == 0:
			#v_box.size_flags_vertical = Control.SIZE_FILL
			#for child in v_box.get_children():
				#child.visible = true if is_expanded else child == $show
			#state = STATE.CLOSED
		#
	#elif state == STATE.OPENING:
		#print("process opening")
		#v_box.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		#for child in v_box.get_children():
			#child.visible = true if is_expanded else child == $show
		#if v_box.custom_minimum_size.y < max_size.y:
			#v_box.custom_minimum_size.y = lerp(last_size.y,max_size.y,0.1)
			#last_size = v_box.custom_minimum_size
			#print("last_size: ", last_size)
		#elif v_box.custom_minimum_size.y == max_size.y:
			#v_box.size_flags_vertical = Control.SIZE_FILL
			#state = STATE.OPEN
