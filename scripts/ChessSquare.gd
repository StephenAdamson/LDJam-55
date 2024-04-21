class_name ChessSquare
extends Sprite2D

var coordinates: Vector2i = Vector2i(0, 0)
enum SquareState { IDLE, HOVERED, POSSIBLE }
var currentState: SquareState = SquareState.IDLE

func _on_area_2d_mouse_entered():
	if currentState == SquareState.IDLE and (GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING or (GameManager.currentGameState == GameManager.GAMESTATE.WHITE_SUMMON_SELECTION and coordinates.x >= 6)):
		changeState(SquareState.HOVERED)
		if GameManager.getPieceAtSquare(Vector2i(coordinates.y,7-coordinates.x)):
			print(GameManager.currentPortrait_holder)
			for child in GameManager.currentPortrait_holder.get_children():
				child.queue_free()
			var _piece = GameManager.getPieceAtSquare(Vector2i(coordinates.y,7-coordinates.x))
			if _piece is KingChessPiece:
				GameManager.currentPortrait = GameManager.KingPortrait
			elif _piece is QueenChessPiece:
				GameManager.currentPortrait = GameManager.QueenPortrait
			elif _piece is RookChessPiece:
				GameManager.currentPortrait = GameManager.RookPortrait
			elif _piece is BishopChessPiece:
				GameManager.currentPortrait = GameManager.BishopPortrait
			elif _piece is KnightChessPiece:
				GameManager.currentPortrait = GameManager.KnightPortrait
			elif _piece is PawnChessPiece:
				GameManager.currentPortrait = GameManager.PawnPortrait
			var _port = GameManager.currentPortrait.instantiate()
			_port.scale = Vector2(0.41,0.41)
			_port.position = Vector2(711,233)
			GameManager.currentPortrait_holder.add_child(_port)

func _on_area_2d_mouse_exited():
	if currentState == SquareState.HOVERED:
		changeState(SquareState.IDLE)
	
func changeState(newState: SquareState):
	if newState == SquareState.HOVERED and currentState == SquareState.POSSIBLE:
		return
	if newState != currentState:
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
				GameManager.currentGameState = GameManager.GAMESTATE.BLACK_PLAYING
				GameManager.complete_turns += 1
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and currentState == SquareState.HOVERED and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_SUMMON_SELECTION and !GameManager.getPieceAtSquare(Vector2i(coordinates.y,7-coordinates.x)):
			GameManager.currentGameState = GameManager.GAMESTATE.BLACK_PLAYING
			GameManager.complete_turns += 1
			GameManager.buyingPiece.setPiecePosition(Vector2i(coordinates.y,7-coordinates.x))
			changeState(SquareState.IDLE)

func update_sprite():
	match currentState:
		SquareState.IDLE:
			self.scale = Vector2(1,1)
			self.texture = load("res://Sprites/square_empty.png")
		SquareState.HOVERED:
			self.scale = Vector2(1,1)
			self.texture = load("res://Sprites/frame_cut.png")
		SquareState.POSSIBLE:
			self.scale = Vector2(0.08,0.08)
			self.texture = load("res://Sprites/possible.png")
