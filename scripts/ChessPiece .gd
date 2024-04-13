class_name ChessPiece
extends Sprite2D
signal piece_clicked

const OFFSET = Vector2(0, -4*64)

@export var viewingAngle = 1.0

@export var cost = 1

func calculatePiecePosition(gridX: int, gridY: int) -> Vector2:
	var gridSize = 64

	var scaledY = gridY * viewingAngle

	var posX = (gridX * gridSize + gridSize / 2) + OFFSET.x
	var posY = (scaledY * gridSize + gridSize / 2) + OFFSET.y
	return Vector2(posX, posY)



func _ready():
	set_process(true)

func setPieceTexture(texture: Texture):
	self.texture = texture

func setPiecePosition(gridX: int, gridY: int):
	position = calculatePiecePosition(gridX, gridY)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				emit_signal("piece_clicked")

func _on_piece_clicked():
	print("clicked on chess piece")
	pass
