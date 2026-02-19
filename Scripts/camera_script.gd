extends Camera2D

@export var zoom_increment = 0.2

@onready var grid_background : Control = %GridBackground

var mouse_button_wheel = [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]
var middle_mouse_currently_pressed = false
var middle_mouse_pivot_position = Vector2(0, 0)

func _ready():
	set_camera_limits()

func _process(_delta):
	if middle_mouse_currently_pressed:
		var gap = middle_mouse_pivot_position - get_global_mouse_position()
		self.position += gap
		
		var viewport_size = get_viewport_rect().size * zoom
		var half_width = viewport_size.x / 2
		var half_height = viewport_size.y / 2
		self.position.x = clamp(self.position.x, self.limit_left + half_width, self.limit_right - half_width)
		self.position.y = clamp(self.position.y, self.limit_top  + half_height, self.limit_bottom - half_height)

func _input(event):
	var mouse_position = get_viewport().get_mouse_position()
	var pre_zoom_value = zoom
	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_MIDDLE:
		middle_mouse_pivot_position = get_global_mouse_position()
		middle_mouse_currently_pressed = event.pressed
		
	if event is InputEventMouseButton \
	and event.button_index in mouse_button_wheel \
	and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN \
		and zoom.x > 0.8:
			zoom -= Vector2(zoom_increment, zoom_increment)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP \
		and zoom.x < 4:
			zoom += Vector2(zoom_increment, zoom_increment)
		
		position += (mouse_position - position) * (Vector2(1, 1) - pre_zoom_value / zoom)


func set_camera_limits():
	var grid_left_side_x = grid_background.position.x
	var grid_right_side_x = grid_background.position.x + grid_background.size.x 
	var grid_top_side_y = grid_background.position.y
	var grid_bottom_side_y = grid_background.position.y + grid_background.size.y
	
	self.limit_bottom = int(grid_bottom_side_y - self.offset.y)
	self.limit_top = int(grid_top_side_y - self.offset.y)
	self.limit_left = int(grid_left_side_x - self.offset.x)
	self.limit_right = int(grid_right_side_x - self.offset.x)


#@onready var tween = $Tween
#@onready var timer = $Timer
#@onready var from := Vector3()
#@onready var to := Vector3()
#
#var viewport_size : Vector2 = Vector2(320, 180)
#var zoom_boundaries : Vector2
#var map_center : Vector2
#var texture_size : Vector2
#var visible_size : Vector2
#var dt_zoom : float
#
#var edge_margin = 5
#var camera_speed = 200.0
#var map_size = Vector2(640, 540)
#var un_zoomed_viewport_size = Vector2(640, 360)
#
#var shake_amplitude : int
#var default_offset : Vector2

#func _process(delta):
	#print("camera delta: ", delta)
	#var mouse_position = get_viewport().get_mouse_position()
	#var move_vector = Vector2.ZERO
	#if mouse_position.x <= edge_margin:
		#move_vector.x = -camera_speed * delta
	#elif mouse_position.x >= un_zoomed_viewport_size.x - edge_margin:
		#move_vector.x = camera_speed * delta
	#if mouse_position.y <= edge_margin:
		#move_vector.y = -camera_speed * delta
	#elif mouse_position.y >= un_zoomed_viewport_size.y - edge_margin:
		#move_vector.y = camera_speed * delta
	#position += move_vector
	#position.x = clamp(position.x, viewport_size.x / zoom_x, map_size.x - viewport_size.x / zoom_x)
	#position.y = clamp(position.y, viewport_size.y / zoom_y, map_size.y - viewport_size.y / zoom_y)	
	
	#var mouse_pos := get_global_mouse_position()
	#$Camera2D.zoom += delta
	#var new_mouse_pos := get_global_mouse_position()
	#$Camera2D.position += mouse_pos - new_mouse_pos
	
	#var mouse_position_new = get_viewport().get_mouse_position()
	#position += mouse_position - mouse_position_new 

#func _ready() -> void:
	#zoom_boundaries = Vector2(0, 0)
	#set_process(false)
#
#func is_zoomed_in() -> bool:
	#return zoom.x == zoom_boundaries.x
#
#func is_zoomed_out() -> bool:
	#return zoom.x == zoom_boundaries.y
#
#func zoom_in(pos : Vector2) -> void:
	#if not is_zoomed_in():
		#move_to(__mouse_2_camera(pos, 1), zoom.x - dt_zoom, duration)
#
#func zoom_out(pos : Vector2) -> void:
	#if not is_zoomed_out():
		#move_to(__mouse_2_camera(pos, 2), zoom.x + dt_zoom, duration)
#
#func slide_to(pos : Vector2) -> void:
	#move_to(__mouse_2_camera(pos, 0), zoom.x, duration)
#
#func drag(vec : Vector2) -> void:
	#move_to(position - (vec * zoom.x), zoom.x, 0)
	#
#func __mouse_2_camera(pos : Vector2, mode : int) -> Vector2:
	#var offset = (pos - viewport_size / 2) 
	#match mode:
		#0:
			#return position + offset * zoom.x
		#1:
			#return position + offset
		#2:
			#return position + offset
	#return position
	#
#
#func move_to(pos : Vector2, z : float, d : float) -> void:
	#if tween.is_active():
		#return
	#set_from()
	#set_to(pos, z)
##	print("Move %s -> %s" % [from, to])
	#if d == 0:
		#__apply(to)
		#return
	#tween.interpolate_method(self, "__apply", from, to, d, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#tween.start()
#
#func __apply(v : Vector3) -> void:
	#position.x = v.x
	#position.y = v.y
	#zoom.x = v.z
	#zoom.y = v.z
#
#func set_from() -> void:
	#from.x = position.x
	#from.y = position.y
	#from.z = zoom.x
#
#func set_to(p : Vector2, z : float) -> void:
	#z = clamp(z, zoom_boundaries.x, zoom_boundaries.y)
	#p = clamp_pos(p, z)
	#to.x = p.x
	#to.y = p.y
	#to.z = z
	#
#func clamp_pos(pos : Vector2, z : float) -> Vector2:
	#visible_size = viewport_size * z
	#var delta = texture_size - (visible_size)
	#if (delta.x <= 0):
		#pos.x = map_center.x
		#visible_size.x = texture_size.x
	#else:
		#var dx = int(delta.x / 2)
		#pos.x = clamp(pos.x, map_center.x - dx, map_center.x + dx)
	#if (delta.y <= 0):
		#pos.y = map_center.y
		#visible_size.y = texture_size.y
	#else:
		#var dy = int(delta.y / 2)
		#pos.y = clamp(pos.y, map_center.y - dy, map_center.y + dy)
	#return pos
