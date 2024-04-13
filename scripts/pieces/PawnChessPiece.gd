# PawnChessPiece.gd
class_name PawnChessPiece
extends ChessPiece

const WHITE_START_POSITIONS = [Vector2(0, 1), Vector2(1, 1), Vector2(2, 1), Vector2(3, 1), Vector2(4, 1), Vector2(5, 1), Vector2(6, 1), Vector2(7, 1)]
const BLACK_START_POSITIONS = [Vector2(0, 6), Vector2(1, 6), Vector2(2, 6), Vector2(3, 6), Vector2(4, 6), Vector2(5, 6), Vector2(6, 6), Vector2(7, 6)]

const WHITE_MOVE_DIRECTION = Vector2(0, 1)
const BLACK_MOVE_DIRECTION = Vector2(0, -1)

const FIRST_MOVE_OFFSET = 2
const NORMAL_MOVE_OFFSET = 1

const ATTACK_OFFSETS = [Vector2(1, 1), Vector2(-1, 1), Vector2(1, -1), Vector2(-1, -1)] # Diagonal moves for capturing

func _ready():
	if get_parent().has_method("getTeam"):
		var parent_team = get_parent().getTeam()
		if parent_team == "white":
			for startPos in WHITE_START_POSITIONS:
				if startPos == position:
					setPieceTexture(load("res://Sprites/pieces/white-pawn-strengths.jpg"))
					break
		else:
			for startPos in BLACK_START_POSITIONS:
				if startPos == position:
					setPieceTexture(load("res://Sprites/pieces/black-pawn-strengths.jpg"))
					break

func _on_piece_clicked():
	var direction = WHITE_MOVE_DIRECTION if get_parent().getTeam() == "white" else BLACK_MOVE_DIRECTION
	var startRow = 1 if get_parent().getTeam() == "white" else 6
	var moveOffset = FIRST_MOVE_OFFSET if position.y == startRow else NORMAL_MOVE_OFFSET

	var newPosX = position.x
	var newPosY = position.y + direction.y * moveOffset

	if newPosY >= 0 and newPosY < 8:
		print("Pawn can move to:", newPosX, newPosY)

	for offset in ATTACK_OFFSETS:
		var targetX = position.x + offset.x
		var targetY = position.y + offset.y
		if targetX >= 0 and targetX < 8 and targetY >= 0 and targetY < 8:
			print("Pawn can capture at:", targetX, targetY)
