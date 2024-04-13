class_name KingChessPiece
extends ChessPiece

const WHITE_START_POSITION = Vector2(2, 0)
const BLACK_START_POSITION = Vector2(4, 7)

const MOVEMENT_OFFSETS = [
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(0, 1),
	Vector2(0, -1),
	Vector2(1, 1),
	Vector2(-1, 1),
	Vector2(1, -1),
	Vector2(-1, -1)
]

func _ready():
	if get_parent().has_method("getTeam"):
		var parent_team = get_parent().getTeam()
		if parent_team == "white":
			setPiecePosition(WHITE_START_POSITION.x, WHITE_START_POSITION.y)
		else:
			setPiecePosition(BLACK_START_POSITION.x, BLACK_START_POSITION.y)
	setPieceTexture(load("res://Sprites/pieces/pawn-strengths.jpg"))


func _on_piece_clicked():
	for offset in MOVEMENT_OFFSETS:
		var newX = position.x + offset.x
		var newY = position.y + offset.y
		if newX >= 0 and newX < 8 and newY >= 0 and newY < 8:
			print("King can move to:", newX, newY)
