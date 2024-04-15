class_name ChessSquare
extends Sprite2D

var coordinates: Vector2i = Vector2i(0, 0)
enum SquareState { IDLE, HOVERED, POSSIBLE }
var currentState: SquareState = SquareState.IDLE

func _on_area_2d_mouse_entered():
	if currentState == SquareState.IDLE and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
		changeState(SquareState.HOVERED)

func _on_area_2d_mouse_exited():
	if currentState == SquareState.HOVERED and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
		changeState(SquareState.IDLE)
	
func changeState(newState: SquareState):
	if newState == SquareState.HOVERED and currentState == SquareState.POSSIBLE:
		return
	currentState = newState
	update_sprite()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
			GameManager.clearBoardHighlights()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and currentState == SquareState.POSSIBLE and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				GameManager.clearBoardHighlights()
				GameManager.chosenPiece.setPiecePosition(Vector2i(coordinates.y,7-coordinates.x))
				if GameManager.chosenPiece.isKing :
					GameManager.white_mana += 1
				

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
