extends Node

var Piece : PackedScene
var Cost : int

var is_x_hovered = false

func _on_mouse_entered():
	is_x_hovered = true
func _on_mouse_exited():
	is_x_hovered = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_BUYING and is_x_hovered:
			print(Piece, Cost)
			GameManager._spellBook.hide_spell_book()
