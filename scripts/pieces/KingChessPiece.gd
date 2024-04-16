class_name KingChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const MOVE_OFFSETS = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, 1), Vector2(0, -1), Vector2( - 1, 1), Vector2(1, 1), Vector2( - 1, -1), Vector2(1, -1)]

func _ready():
	isKing = true
	points_per_capture = 100
	if team == 0:
		self.texture = load("res://Sprites/pieces/white/whitewizardfront.png")
	else:
		self.texture = load("res://Sprites/pieces/black/blackwizardfront.png")

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y * direction.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)):
				if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)).team != team:
					possibleSquares.append(Vector2i(targetX, targetY))
					continue
				else:
					continue
			possibleSquares.append(Vector2i(targetX, targetY))
	return possibleSquares

func calculate_captures():
	possibleCaptures = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION
	for _offset in MOVE_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y * direction.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)):
				if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)).team != team:
					possibleCaptures.append(Vector2i(targetX, targetY))
					continue
				else:
					continue
	return possibleCaptures
