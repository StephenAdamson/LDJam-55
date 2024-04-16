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

var currentPortrait_holder
var currentPortrait

var KingPortrait : PackedScene = load("res://prefabs/Portraits/King.tscn")
var QueenPortrait : PackedScene = load("res://prefabs/Portraits/Queen.tscn")
var KnightPortrait : PackedScene = load("res://prefabs/Portraits/Knight.tscn")
var BishopPortrait : PackedScene = load("res://prefabs/Portraits/Bishop.tscn")
var RookPortrait : PackedScene = load("res://prefabs/Portraits/Rook.tscn")
var PawnPortrait : PackedScene = load("res://prefabs/Portraits/Pawn.tscn")

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
	BLACK_SCROLL_SELECTION,
	WIN,
	LOSE
}
var currentGameState = GAMESTATE.WHITE_PLAYING
var chosenPiece
var buyingPiece

var _spellBook
var _shopIcon

var white_mana = 0
var black_mana = 0

var black_pieces = []

var chances = [1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]

func _ready():
	instance = self
	board = []
	currentPortrait_holder = Node2D.new()
	add_child(currentPortrait_holder)
	for y in range(8):
		board.append([])
		for x in range(8):
			var square = Square.instantiate()
			square.position = Vector2(x*64.0+32+232, y*64.0+32+119)
			square.coordinates = Vector2i(y, x)
			board[y].append(square)
			add_child(board[y][x])
	chosenPiece = spawn_white_king_piece()
	black_pieces.append(spawn_black_king_piece())
	
	_shopIcon = ShopIcon.instantiate()
	_shopIcon.position = Vector2(90,600)
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
	
func _process(delta):
	if currentGameState == GAMESTATE.WHITE_SUMMON_SELECTION and buyingPiece:
		buyingPiece.position = buyingPiece.get_global_mouse_position()
	if currentGameState == GAMESTATE.BLACK_PLAYING:
		black_ai()

func black_ai():
	var decision = randi() % 7
	for _piece in black_pieces:
		if _piece.calculate_captures().size()>0:
			decision=10
		
	if black_mana >= 2 and getSpawnableZonesBlack().size()>0:
		decision = randi() % 7
		if decision == 0 :
			var hasBought = 0
			while hasBought == 0:
				var selection = chances[randi() % chances.size()]
				var _piece
				match selection:
					1:
						if black_mana >= 2:
							black_mana -= 2
							hasBought = selection
							_piece = Pawn.instantiate()
					2:
						if black_mana >= 6:
							black_mana -= 6
							hasBought = selection
							_piece = Knight.instantiate()
					3:
						if black_mana >= 6:
							black_mana -= 6
							hasBought = selection
							_piece = Bishop.instantiate()
					4:
						if black_mana >= 10:
							black_mana -= 10
							hasBought = selection
							_piece = Rook.instantiate()
					5:
						if black_mana >= 18:
							black_mana -= 18
							hasBought = selection
							_piece = Queen.instantiate()
				if hasBought > 0:
					_piece.team = 1
					_piece.setPiecePosition(getSpawnableZonesBlack()[randi() % getSpawnableZonesBlack().size()])
					black_pieces.append(_piece)
					add_child(_piece)
					
			currentGameState = GAMESTATE.WHITE_PLAYING
		else:
			black_move_a_piece()
	else:
		black_move_a_piece()

func black_move_a_piece():
	var canMove = false
	while !canMove:
		var _piece = black_pieces[randi() % black_pieces.size()]
		var _moves = _piece.calculate_captures()
		if _moves.size() == 0:
			_moves = _piece.calculate_moves()
		var _possible = []
		for _sq in getAvailibleZones():
			if _sq in _moves:
				_possible.append(_sq)
		if _possible.size() > 0:
			canMove = true
		else:
			continue
		if _piece.calculate_captures().size() == 0:
			_piece.setPiecePosition(_possible[randi() % _possible.size()]);
		else:
			var _largest = 0
			var _toCapture
			for __piece in _possible:
				if getPieceAtSquare(__piece).points_per_capture > _largest:
					var ___piece = getPieceAtSquare(__piece)
					_largest = ___piece.points_per_capture
					_toCapture = ___piece
			_piece.setPiecePosition(_toCapture.currentGridPosition);
			black_mana += _toCapture.points_per_capture
			if _toCapture.isKing:
				currentGameState = GAMESTATE.LOSE
			_toCapture.queue_free()
			break
		currentGameState = GAMESTATE.WHITE_PLAYING
		if _piece.isKing:
			black_mana +=1

func spawn_white_king_piece():
	var king_piece = King.instantiate()
	king_piece.team = 0
	king_piece.setPiecePosition(Vector2i(0, 0))
	add_child(king_piece)
	return king_piece

func spawn_black_king_piece():
	var king_piece = King.instantiate()
	king_piece.team = 1
	king_piece.setPiecePosition(Vector2i(7, 7))
	add_child(king_piece)
	return king_piece

func clearBoardHighlights():
	for y in range(8):
		for x in range(8):
			GameManager.board[y][x].changeState(ChessSquare.SquareState.IDLE)

func getSpawnableZonesBlack():
	var spawnable_slots = []
	for row in range(7, 5, -1):
		for col in range(8):
			spawnable_slots.append(Vector2i(col, row))
	var found_slots = []
	for _piece in get_children_of_type_chess_piece():
		for slot in spawnable_slots:
			if slot == _piece.currentGridPosition:
				found_slots.append(slot)
	var i = 0
	while i < spawnable_slots.size():
		if found_slots.has(spawnable_slots[i]):
			spawnable_slots.remove_at(i)
		else:
			i += 1
	return spawnable_slots
	
func getSpawnableZonesWhite():
	var spawnable_slots = []
	for row in range(2):
		for col in range(8):
			spawnable_slots.append(Vector2i(col, row))
	var found_slots = []
	for _piece in get_children_of_type_chess_piece():
		for slot in spawnable_slots:
			if slot == _piece.currentGridPosition:
				found_slots.append(slot)
	var i = 0
	while i < spawnable_slots.size():
		if found_slots.has(spawnable_slots[i]):
			spawnable_slots.remove_at(i)
		else:
			i += 1
	return spawnable_slots

func getAvailibleZones():
	var spawnable_slots = []
	for row in range(8):
		for col in range(8):
			spawnable_slots.append(Vector2i(col, row))
	var found_slots = []
	for _piece in get_children_of_type_chess_piece():
		if currentGameState == GAMESTATE.BLACK_PLAYING and _piece.team == 0:
			continue
		if currentGameState == GAMESTATE.WHITE_PLAYING and _piece.team == 1:
			continue
		for slot in spawnable_slots:
			if slot == _piece.currentGridPosition:
				found_slots.append(slot)
	var i = 0
	while i < spawnable_slots.size():
		if found_slots.has(spawnable_slots[i]):
			spawnable_slots.remove_at(i)
		else:
			i += 1
	return spawnable_slots
	
func getPieceAtSquare(pos:Vector2i) -> ChessPiece:
	for _piece in get_children_of_type_chess_piece():
		if _piece.currentGridPosition == pos:
			return _piece
	return

func get_children_of_type_chess_piece() -> Array:
	var chess_piece_children = []
	for child in get_children():
		if child is ChessPiece:
			chess_piece_children.append(child)
	return chess_piece_children
