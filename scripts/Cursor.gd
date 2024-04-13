extends Control

var grid_size = Vector2(32, 32) # Adjust the grid size as needed
var start_pos = Vector2.ZERO
var is_dragging = false

func _ready():
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_pos = snap_to_grid(get_global_mouse_position())
				is_dragging = true
			else:
				is_dragging = false

func snap_to_grid(position):
	var snapped_x = round(position.x / grid_size.x) * grid_size.x
	var snapped_y = round(position.y / grid_size.y) * grid_size.y
	return Vector2(snapped_x, snapped_y)

func _draw():
	if is_dragging:
		print("TEST")
		draw_rect(Rect2(start_pos, get_global_mouse_position() - start_pos), Color(1, 1, 1, 0.5))
