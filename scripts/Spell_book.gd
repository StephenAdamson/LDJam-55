extends Control

var is_x_hovered = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_BUYING:
			hide_spell_book()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and is_x_hovered and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_BUYING:
			hide_spell_book()


func _on_area_2d_mouse_entered():
	is_x_hovered = true


func _on_area_2d_mouse_exited():
	is_x_hovered = false

func hide_spell_book():
	GameManager.currentGameState = GameManager.GAMESTATE.WHITE_PLAYING
	visible = false
