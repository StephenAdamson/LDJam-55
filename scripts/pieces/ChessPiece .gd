class_name ChessPiece
extends Sprite2D
signal piece_clicked

const OFFSET = Vector2(0, 0)

var viewingAngle = 1
var points_per_capture = 1

var currentGridPosition = Vector2(-1,-1)
var possibleSquares = [Vector2i(-1, -1)]

var isKing = false

var team = 0

func calculatePiecePosition(pos :Vector2i) -> Vector2:
	var gridSize = 64
	var scaledY = pos.y * viewingAngle
	
	var posX = (pos.x * gridSize + gridSize / 2.0) + OFFSET.x
	var posY = (gridSize*8)-(scaledY * gridSize + gridSize / 2.0) + OFFSET.y
	return Vector2(posX, posY)

func _ready():
	set_process(true)

func setPieceTexture(_texture: Texture):
	self.texture = _texture

func setPiecePosition(pos: Vector2i):
	currentGridPosition = pos
	position = calculatePiecePosition(currentGridPosition)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and team == 0:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				if GameManager.instance:
					GameManager.chosenPiece = self
					if GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
						if has_method("calculate_moves"):
							GameManager.clearBoardHighlights()
							var moves = call("calculate_moves")
							for move in moves:
								for y in range(8):
									for x in range(8):
										if move.x == x and move.y == y:
											GameManager.board[7-y][x].changeState(ChessSquare.SquareState.POSSIBLE)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and GameManager.GAMESTATE.WHITE_PLAYING and team == 1:
			for row in GameManager.board:
				for square in row:
					if square.coordinates.x == 7-currentGridPosition.y and square.coordinates.y == currentGridPosition.x and square.currentState == 2 and get_rect().has_point(get_local_mouse_position()):
						GameManager.chosenPiece.setPiecePosition(currentGridPosition)
						GameManager.currentGameState= GameManager.GAMESTATE.BLACK_PLAYING
						GameManager.clearBoardHighlights()
						if isKing:
							GameManager.currentGameState = GameManager.GAMESTATE.WIN
						queue_free()

func getPossibleMoves():
	return possibleSquares
