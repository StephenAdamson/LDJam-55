class_name BishopChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const MOVE_OFFSETS = [Vector2(-1, 1), Vector2(1, 1), Vector2(-1, -1), Vector2(1, -1)] # Diagonal moves

var team = 0

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS:
		var newPosX = currentGridPosition.x + _offset.x
		var newPosY = currentGridPosition.y + _offset.y * direction.y
		while newPosX >= 0 and newPosX < 8 and newPosY >= 0 and newPosY < 8:
			possibleSquares.append(Vector2i(newPosX, newPosY))
			newPosX += _offset.x
			newPosY += _offset.y * direction.y
	return possibleSquares
