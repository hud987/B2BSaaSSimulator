extends TileMapLayer
#extends ColorRect

@export var cell_size : Vector2 = Vector2(32, 32)
@export var grid_size : Vector2i = Vector2i(40, 30)

func _draw():
	# Draw vertical lines
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0), Vector2(x * cell_size.x, grid_size.y * cell_size.y), Color.DIM_GRAY, 1.0)
	# Draw horizontal lines
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y), Vector2(grid_size.x * cell_size.x, y * cell_size.y), Color.DIM_GRAY, 1.0)
