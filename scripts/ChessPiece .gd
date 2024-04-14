class_name ChessPiece
extends Sprite2D
signal piece_clicked

const OFFSET = Vector2(0, 0)

@export var viewingAngle = 1.0

@export var cost = 1

var currentGridPosition = Vector2(-1,-1)
var possibleSquares = [Vector2i(-1, -1)]

func calculatePiecePosition(pos :Vector2i) -> Vector2:
	var gridSize = 64
	var scaledY = pos.y * viewingAngle

	var posX = (pos.x * gridSize + gridSize / 2.0) + OFFSET.x
	var posY = (gridSize*8)-(scaledY * gridSize + gridSize / 2.0) + OFFSET.y
	return Vector2(posX, posY)

func _ready():
	set_process(true)

func setPieceTexture(_texture: Texture):
	self.texture = _texture

func setPiecePosition(pos: Vector2i):
	var old = calculatePiecePosition(currentGridPosition)
	var new = calculatePiecePosition(pos)
	currentGridPosition = pos
	position = calculatePiecePosition(currentGridPosition)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#var mouse_pos = get_local_mouse_position()
			#if get_rect().has_point(mouse_pos):
			emit_signal("piece_clicked")

func _on_piece_clicked():
	if GameManager.instance:
		if GameManager.is_players_turn():
			if has_method("calculate_moves"):
				var moves = call("calculate_moves")
				setPiecePosition(moves[randi() % moves.size()])


func getPossibleMoves():
	return possibleSquares
