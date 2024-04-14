class_name PawnChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const ATTACK_OFFSETS = [Vector2(-1, 1), Vector2(1, 1)] # Diagonal moves for capturing

var team = 0

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION

	var newPosX = currentGridPosition.x
	var newPosY = currentGridPosition.y + direction.y

	if newPosY >= 0 and newPosY < 8:
		possibleSquares.append(Vector2i(newPosX, newPosY))

	for _offset in ATTACK_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			possibleSquares.append(Vector2i(targetX, targetY))
	if possibleSquares == []:
		possibleSquares.append(Vector2i(-1,-1))
	return possibleSquares
