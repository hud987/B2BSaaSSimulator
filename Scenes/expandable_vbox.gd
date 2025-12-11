extends VBoxContainer

@export var is_expanded = true

enum STATE {OPEN,CLOSE,OPENING,CLOSING}

var init = false
var state :STATE
var max_size : Vector2i
var last_size : Vector2i

@onready var v_box = $"."

func _ready():
	state = STATE.OPEN

#func _gui_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#self.expand()


func _on_button_pressed():
	print("_on_button_pressed")
	expand()
	pass # Replace with function body.

func expand():
	print("expand")
	is_expanded = !is_expanded
	if is_expanded:
		state = STATE.OPENING
	else:
		state = STATE.CLOSING

func _process(delta):
	print("_process")
	if not init:
		max_size = v_box.size
		last_size = v_box.size
		v_box.custom_minimum_size.y = max_size.y
		init = true
	
	if state == STATE.CLOSING:
		v_box.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		if v_box.custom_minimum_size.y > 0:
			v_box.custom_minimum_size.y = lerp(last_size.y,0,0.1)
			last_size = v_box.custom_minimum_size
		elif v_box.custom_minimum_size.y == 0:
			v_box.size_flags_vertical = Control.SIZE_FILL
			for child in v_box.get_children():
				child.visible = true if is_expanded else child == $show
			state = STATE.CLOSE
		
		elif state == STATE.OPENING:
			v_box.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
			for child in v_box.get_children():
				child.visible = true if is_expanded else child == $show
			if v_box.custom_minimum_size.y < max_size.y:
				v_box.custom_minimum_size.y = lerp(last_size.y,max_size.y,0.1)
				last_size = v_box.custom_minimum_size
			elif v_box.custom_minimum_size.y == max_size.y:
				v_box.size_flags_vertical = Control.SIZE_FILL
				state = STATE.OPEN
