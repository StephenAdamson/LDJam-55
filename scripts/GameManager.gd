extends Node

static var instance

var King : PackedScene = load("res://prefabs/pieces/King.tscn")
var Queen : PackedScene = load("res://prefabs/pieces/Queen.tscn")
var Knight : PackedScene = load("res://prefabs/pieces/Knight.tscn")
var Bishop : PackedScene = load("res://prefabs/pieces/Bishop.tscn")
var Rook : PackedScene = load("res://prefabs/pieces/Rook.tscn")
var Pawn : PackedScene = load("res://prefabs/pieces/Pawn.tscn")

var SpellBook : PackedScene = load("res://prefabs/book/Spell_book_main.tscn")
var ShopIcon : PackedScene = load("res://prefabs/Shop_icon.tscn")
var Square : PackedScene = load("res://prefabs/Square.tscn")
var ShopItem : PackedScene = load("res://prefabs/shop_item.tscn")

var board = []
enum GAMESTATE {
	WHITE_BUYING, 
	WHITE_PLAYING, 
	WHITE_SUMMON_SELECTION,
	BLACK_BUYING,
	BLACK_PLAYING,
	BLACK_SUMMON_SELECTION,
	ANIMATION,
	SCROLL_DIALOGUE,
	WHITE_SCROLL_SELECTION,
	BLACK_SCROLL_SELECTION
}
var currentGameState = GAMESTATE.WHITE_PLAYING
var chosenPiece
var buyingPiece

var _spellBook
var _shopIcon

var white_mana = 0
var black_mana = 0

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
	
	_shopIcon = ShopIcon.instantiate()
	_shopIcon.position = Vector2(60,600)
	add_child(_shopIcon)
	
	_spellBook = SpellBook.instantiate()
	_spellBook.visible = false
	add_child(_spellBook)
	
	var pawn_shop = ShopItem.instantiate()
	pawn_shop.position = Vector2(400,220)
	pawn_shop.Piece = Pawn
	pawn_shop.Cost = 2
	_spellBook.add_child(pawn_shop)
	var knight_shop = ShopItem.instantiate()
	knight_shop.position = Vector2(400,370)
	knight_shop.Piece = Knight
	knight_shop.Cost = 6
	_spellBook.add_child(knight_shop)
	var bishop_shop = ShopItem.instantiate()
	bishop_shop.position = Vector2(740,130)
	bishop_shop.Piece = Bishop
	bishop_shop.Cost = 6
	_spellBook.add_child(bishop_shop)
	var rook_shop = ShopItem.instantiate()
	rook_shop.position = Vector2(740,260)
	rook_shop.Piece = Rook
	rook_shop.Cost = 10
	_spellBook.add_child(rook_shop)
	var queen_shop = ShopItem.instantiate()
	queen_shop.position = Vector2(740,400)
	queen_shop.Piece = Queen
	queen_shop.Cost = 18
	_spellBook.add_child(queen_shop)
	

func spawn_king_piece():
	var king_piece = King.instantiate()
	king_piece.team = 0
	king_piece.setPiecePosition(Vector2i(4, 0))
	add_child(king_piece)
	return king_piece
	
func clearBoardHighlights():
	for y in range(8):
		for x in range(8):
			GameManager.board[7-y][x].changeState(ChessSquare.SquareState.IDLE)

