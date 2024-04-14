extends Node2D

@export var coordinates: Vector2i = Vector2i(0, 0)
enum SquareState { IDLE, HOVERED, POSSIBLE }
@export var currentState: SquareState = SquareState.IDLE

func _on_area_2d_mouse_entered():
	currentState = SquareState.HOVERED
	update_sprite()

func _on_area_2d_mouse_exited():
	currentState = SquareState.IDLE
	update_sprite()

func update_sprite():
	match currentState:
		SquareState.IDLE:
			$Sprite2D.visible = false
		SquareState.HOVERED:
			$Sprite2D.visible = true
			$Sprite2D.texture = load("res://Sprites/Pasted image.png")
		SquareState.POSSIBLE:
			$Sprite2D.visible = true
			$Sprite2D.texture = load("res://Sprites/Pasted image 1.png")
