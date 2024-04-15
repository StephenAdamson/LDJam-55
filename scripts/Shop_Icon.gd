class_name Shop_Icon
extends Sprite2D

enum ShopIconState { IDLE, HOVERED }
var currentState: ShopIconState = ShopIconState.IDLE

func _on_area_2d_mouse_entered():
	if currentState == ShopIconState.IDLE:
		changeState(ShopIconState.HOVERED)

func _on_area_2d_mouse_exited():
	if currentState == ShopIconState.HOVERED:
		changeState(ShopIconState.IDLE)
	
func changeState(newState: ShopIconState):
	currentState = newState
	update_sprite()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and GameManager.currentGameState == GameManager.GAMESTATE.WHITE_PLAYING:
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				changeState(ShopIconState.IDLE)
				GameManager.currentGameState = GameManager.GAMESTATE.WHITE_BUYING
				GameManager._spellBook.visible = true

func update_sprite():
	match currentState:
		ShopIconState.IDLE:
			self.visible = true
			self.texture = load("res://Sprites/Spell_icon.png")
		ShopIconState.HOVERED:
			self.visible = true
			self.texture = load("res://Sprites/Spell_icon_hovered.png")
