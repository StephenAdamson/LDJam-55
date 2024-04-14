class_name ChessSquare
extends Sprite2D

@export var coordinates: Vector2i = Vector2i(0, 0)
enum SquareState { IDLE, HOVERED, POSSIBLE }
@export var currentState: SquareState = SquareState.IDLE

func _on_area_2d_mouse_entered():
	if currentState == SquareState.IDLE:
		changeState(SquareState.HOVERED)

func _on_area_2d_mouse_exited():
	if currentState == SquareState.HOVERED:
		changeState(SquareState.IDLE)
	
func changeState(newState: SquareState):
	if newState == SquareState.HOVERED and currentState == SquareState.POSSIBLE:
		return
	currentState = newState
	update_sprite()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and currentState == SquareState.POSSIBLE:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				GameManager.chosenPiece.setPiecePosition(Vector2i(coordinates.y,7-coordinates.x))
				GameManager.clearBoardHighlights()

func update_sprite():
	match currentState:
		SquareState.IDLE:
			self.visible = true
			self.texture = load("res://Sprites/square_1.png")
		SquareState.HOVERED:
			self.visible = true
			self.texture = load("res://Sprites/square_2.png")
		SquareState.POSSIBLE:
			self.visible = true
			self.texture = load("res://Sprites/square_2.png")
