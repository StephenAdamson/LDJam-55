class_name ChessPiece
extends Sprite2D
signal piece_clicked

const OFFSET = Vector2(0, 0)

var viewingAngle = 1

@export var cost = 1

var currentGridPosition = Vector2(-1,-1)
var possibleSquares = [Vector2i(-1, -1)]

var isKing = false

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
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				emit_signal("piece_clicked")

func _on_piece_clicked():
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

func getPossibleMoves():
	return possibleSquares
