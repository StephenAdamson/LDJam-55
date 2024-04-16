extends Label

var time = 0

func _process(delta):
	time = time + delta
	if time > 0.0416:
		time = 0
		if GameManager.currentGameState == GameManager.GAMESTATE.WIN:
			text = "WINNER!"
		elif GameManager.currentGameState == GameManager.GAMESTATE.LOSE:
			text = "You lose!  :(  womp womp"
		else:
			text = "You have " + str(GameManager.white_mana) + " mana"
