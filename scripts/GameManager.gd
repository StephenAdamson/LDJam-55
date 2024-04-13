extends Node


static var instance


func _ready():
	instance = self

var white_mana = 0

func add_to_white_mana(points):
	white_mana += points

func spend_white_mana(points):
	white_mana -= points
	
func reset_white_mana():
	white_mana = 0

func get_white_mana():
	return white_mana

var black_mana = 0

func add_to_black_mana(points):
	white_mana += points

func spend_black_mana(points):
	white_mana -= points
	
func reset_black_mana():
	white_mana = 0

func get_black_mana():
	return white_mana
