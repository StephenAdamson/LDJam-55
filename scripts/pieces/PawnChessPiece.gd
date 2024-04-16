class_name PawnChessPiece
extends ChessPiece

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)
const ATTACK_OFFSETS = [Vector2(-1, 1), Vector2(1, 1)]

func _ready():
	points_per_capture = 1
	if team == 0:
		self.texture = load("res://Sprites/pieces/white/whitepawnfront.png")
	else:
		self.texture = load("res://Sprites/pieces/black/blackpawnfront.png")

func calculate_moves():
	possibleSquares = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION

	var newPosX = currentGridPosition.x
	var newPosY = currentGridPosition.y + direction.y

	if newPosY >= 0 and newPosY < 8 and !GameManager.getPieceAtSquare(Vector2i(newPosX,newPosY)):
		possibleSquares.append(Vector2i(newPosX, newPosY))

	for _offset in ATTACK_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY
		if team == 0:
			targetY = currentGridPosition.y + _offset.y
		else:
			targetY = currentGridPosition.y - _offset.y
		
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8 and GameManager.getPieceAtSquare(Vector2i(targetX,targetY)) and GameManager.getPieceAtSquare(Vector2i(targetX,targetY)).team!=team:
			possibleSquares.append(Vector2i(targetX, targetY))
	if possibleSquares == []:
		possibleSquares.append(Vector2i(-1,-1))
	return possibleSquares

func calculate_captures():
	possibleCaptures = []
	var direction = WHITE_MOVE_DIRECTION if team == 0 else BLACK_MOVE_DIRECTION

	var newPosX = currentGridPosition.x
	var newPosY = currentGridPosition.y + direction.y

	for _offset in ATTACK_OFFSETS:
		var targetX = currentGridPosition.x + _offset.x
		var targetY = currentGridPosition.y + _offset.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8 and GameManager.getPieceAtSquare(Vector2i(targetX,targetY)) and GameManager.getPieceAtSquare(Vector2i(targetX,targetY)).team!=team:
			possibleCaptures.append(Vector2i(targetX, targetY))
	return possibleCaptures
