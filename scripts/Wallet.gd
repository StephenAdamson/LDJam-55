extends Label

var time = 0

func _process(delta):
	time = time + delta
	if time > 0.0416:
		time = 0
		text = "You have " + str(GameManager.white_mana) + " mana"
