class_name KnightChessPiece
extends ChessPiece

const WHITE_START_POSITION = Vector2(1, 0)
const BLACK_START_POSITION = Vector2(6, 7)

const MOVEMENT_OFFSETS = [
	Vector2(1, 2),
	Vector2(1, -2),
	Vector2(-1, 2),
	Vector2(-1, -2),
	Vector2(2, 1),
	Vector2(2, -1),
	Vector2(-2, 1),
	Vector2(-2, -1),
]

func _ready():
	if get_parent().has_method("getTeam"):
		var parent_team = get_parent().getTeam()
		if parent_team == "white":
			setPiecePosition(WHITE_START_POSITION.x, WHITE_START_POSITION.y)
		else:
			setPiecePosition(BLACK_START_POSITION.x, BLACK_START_POSITION.y)
	setPieceTexture(load("res://Sprites/pieces/knight-strengths.jpg"))

func _on_piece_clicked():
	for offset in MOVEMENT_OFFSETS:
		var newX = position.x + offset.x
		var newY = position.y + offset.y
		if newX >= 0 and newX < 8 and newY >= 0 and newY < 8:
			print("Knight can move to:", newX, newY)
