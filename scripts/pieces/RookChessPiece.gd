class_name RookChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const MOVE_OFFSETS = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, 1), Vector2(0, -1)]

func _ready():
	points_per_capture = 5

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS:
		var newPosX = currentGridPosition.x + _offset.x
		var newPosY = currentGridPosition.y + _offset.y * direction.y
		while newPosX >= 0 and newPosX < 8 and newPosY >= 0 and newPosY < 8:
			if GameManager.getPieceAtSquare(Vector2i(newPosX, newPosY)):
				if GameManager.getPieceAtSquare(Vector2i(newPosX, newPosY)).team != team:
					possibleSquares.append(Vector2i(newPosX, newPosY))
					break
				else:
					break
			possibleSquares.append(Vector2i(newPosX, newPosY))
			newPosX += _offset.x
			newPosY += _offset.y * direction.y
	return possibleSquares

func calculate_captures():
	possibleCaptures = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS:
		var newPosX = currentGridPosition.x + _offset.x
		var newPosY = currentGridPosition.y + _offset.y * direction.y
		while newPosX >= 0 and newPosX < 8 and newPosY >= 0 and newPosY < 8:
			if GameManager.getPieceAtSquare(Vector2i(newPosX, newPosY)):
				if GameManager.getPieceAtSquare(Vector2i(newPosX, newPosY)).team != team:
					possibleCaptures.append(Vector2i(newPosX, newPosY))
					break
				else:
					break
			newPosX += _offset.x
			newPosY += _offset.y * direction.y
	return possibleCaptures
