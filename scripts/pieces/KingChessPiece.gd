class_name KingChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const ATTACK_OFFSETS = [Vector2( - 1, 1), Vector2(1, 1), Vector2( - 1, -1), Vector2(1, -1)] # Diagonal moves for capturing
const MOVE_OFFSETS = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, 1), Vector2(0, -1)] # Vertical and horizontal moves

var team = 0

func _ready():
	isKing = true

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS + ATTACK_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y * direction.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			possibleSquares.append(Vector2i(targetX, targetY))
	return possibleSquares
