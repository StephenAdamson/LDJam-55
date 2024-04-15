class_name KnightChessPiece
extends ChessPiece

const MOVE_OFFSETS = [Vector2(-2, 1), Vector2(-1, 2), Vector2(1, 2), Vector2(2, 1), Vector2(2, -1), Vector2(1, -2), Vector2(-1, -2), Vector2(-2, -1)] # Knight's possible moves

func _ready():
	points_per_capture = 3

func calculate_moves():
	possibleSquares = []
	for _offset in MOVE_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			possibleSquares.append(Vector2i(targetX, targetY))
	return possibleSquares
