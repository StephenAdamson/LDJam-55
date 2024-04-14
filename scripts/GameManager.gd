extends Node

static var instance

var King : PackedScene = load("res://prefabs/pieces/King.tscn")
var Knight : PackedScene = load("res://prefabs/pieces/Knight.tscn")
var Square : PackedScene = load("res://prefabs/Square.tscn")

var board = []
enum GAMESTATE {WHITE_BUYING, WHITE_PLAYING, BLACK_BUYING, BLACK_PLAYING, ANIMATION, SCROLL_DIALOGUE, WHITE_SCROLL_SELECTION, BLACK_SCROLL_SELECTION}
var currentGameState = GAMESTATE.WHITE_PLAYING
var chosenPiece

func _ready():
	instance = self
	board = []
	for y in range(8):
		board.append([])
		for x in range(8):
			var square = Square.instantiate()
			square.position = Vector2(x*64.0+32, y*64.0+32)
			square.coordinates = Vector2i(y, x)
			board[y].append(square)
			add_child(board[y][x])
	chosenPiece = spawn_king_piece()

func spawn_king_piece():
	var king_piece = Knight.instantiate()
	king_piece.team = 0
	king_piece.setPiecePosition(Vector2i(3, 0))
	add_child(king_piece)
	return king_piece
	
func clearBoardHighlights():
	for y in range(8):
		for x in range(8):
			GameManager.board[7-y][x].changeState(ChessSquare.SquareState.IDLE)

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
