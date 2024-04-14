extends Node

static var instance

var King : PackedScene = load("res://prefabs/pieces/King.tscn")

func _ready():
	instance = self
	spawn_king_piece()

func spawn_king_piece():
	var king_piece = King.instantiate()
	king_piece.team = 0
	king_piece.setPiecePosition(Vector2i(3, 0))
	add_child(king_piece)

var players_turn:bool = true


func is_players_turn():
	return players_turn

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
