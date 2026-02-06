extends Camera2D

@export var zoom_increment = 0.2

@onready var grid_background : Control = %GridBackground

var mouse_button_wheel = [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]

func _input(event):
	if event is InputEventMouseButton \
	and event.button_index in mouse_button_wheel \
	and event.pressed:
		var mouse_position = get_viewport().get_mouse_position()
		var pre_zoom_value = zoom
		
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN \
		and zoom.x > 0.8:
			zoom -= Vector2(zoom_increment, zoom_increment)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP \
		and zoom.x < 4:
			zoom += Vector2(zoom_increment, zoom_increment)
			
		position += (mouse_position - position) * (Vector2(1, 1) - pre_zoom_value / zoom)
		position.x = clamp(position.x, grid_background.position.x, grid_background.size.x)
		position.y = clamp(position.y, grid_background.position.y, grid_background.size.y)
		print("zoom: ", zoom)
		print("camera position: ", position)
		print("grid_background position: ", grid_background.position)
		print("grid_background size: ", grid_background.size)




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
