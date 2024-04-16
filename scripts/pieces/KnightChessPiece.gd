class_name KnightChessPiece
extends ChessPiece

const MOVE_OFFSETS = [Vector2(-2, 1), Vector2(-1, 2), Vector2(1, 2), Vector2(2, 1), Vector2(2, -1), Vector2(1, -2), Vector2(-1, -2), Vector2(-2, -1)] # Knight's possible moves

func _ready():
	points_per_capture = 3
	if team == 0:
		self.texture = load("res://Sprites/pieces/white/whiteknightfront_20240415224556.png")
	else:
		self.texture = load("res://Sprites/pieces/black/blackknightfront_20240415224539.png")

func calculate_moves():
	possibleSquares = []
	for _offset in MOVE_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y
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
	for _offset in MOVE_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)):
				if GameManager.getPieceAtSquare(Vector2i(targetX, targetY)).team != team:
					possibleCaptures.append(Vector2i(targetX, targetY))
					continue
				else:
					continue
	return possibleCaptures
