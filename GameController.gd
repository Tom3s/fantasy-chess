extends Node2D

class_name GameController

const Player := preload("res://Player.tscn")

var players: Array[Player]

var currentPlayerIndex: int

var defaultPieces: Array[String] = [PieceNames.PAWN, PieceNames.KNIGHT, PieceNames.ROOK, PieceNames.BISHOP, PieceNames.QUEEN, PieceNames.ROOK, PieceNames.BISHOP, PieceNames.KNIGHT, PieceNames.PAWN]

var player1Queue: Array[Piece]
var player2Queue: Array[Piece]

var currentQueue: int

signal nextPieceSelected(piece: Piece)

# Called when the node enters the scene tree for the first time.
func _ready():
	# player1
	var player := Player.instantiate()
	add_child(player)
	player.init("Cyan", Color.CYAN, 0, defaultPieces)
	players.append(player)

	# player2
	player = Player.instantiate()
	add_child(player)
	player.init("Orange", Color.CORAL, GlobalVariables.BOARD_HEIGHT - 1, defaultPieces)
	players.append(player)

	currentPlayerIndex = 0

	player1Queue = players[0].pieces.duplicate()
	player2Queue = players[1].pieces.duplicate()
	
	player1Queue.shuffle()
	player2Queue.shuffle()
	
	

	nextPieceSelected.emit(player1Queue[0])
	# players[currentPlayerIndex].startTurn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getAllPlayers() -> Array[Player]:
	return players

func getCurrentPlayer() -> Player:
	return players[currentPlayerIndex]

func getEnemyPlayer() -> Player:
	var enemyPlayerIndex := (currentPlayerIndex + 1) % players.size()
	return players[enemyPlayerIndex]

func nextPlayer():
	currentPlayerIndex = (currentPlayerIndex + 1) % players.size()
	# players[currentPlayerIndex].startTurn()
	nextPieceSelected.emit(getNextPiece())

func getAllOccupiedTiles() -> Array[Vector2i]:
	var occupiedTiles: Array[Vector2i] = []
	for player in players:
		occupiedTiles.append_array(player.getOccupiedTiles())
	return occupiedTiles

func getCurrentPlayerOccupiedTiles() -> Array[Vector2i]:
	return players[currentPlayerIndex].getOccupiedTiles()

func getEnemyPlayerOccupiedTiles() -> Array[Vector2i]:
	var enemyPlayerIndex := (currentPlayerIndex + 1) % players.size()
	return players[enemyPlayerIndex].getOccupiedTiles()

func debugCurrentPlayer() -> String:
	return "Current player: " + str(currentPlayerIndex) + " - " + players[currentPlayerIndex].playerName

func debugCurrentPiece() -> String:
	var currentPieceName = ""
	if currentQueue == 0:
		currentPieceName = player1Queue[0].pieceType
	else:
		currentPieceName = player2Queue[0].pieceType
	return "Current piece: " + currentPieceName

func getNextPiece() -> Piece:
	if currentQueue == 1:
		player1Queue.append(player1Queue.pop_front())
		currentQueue = 0
		return player1Queue[0]
	else:
		player2Queue.append(player2Queue.pop_front())
		currentQueue = 1
		return player2Queue[0]
	# pieceQueue.append(pieceQueue.pop_front())
	# return pieceQueue[0]

func onPieceDeath(piece: Piece):
	if player1Queue.has(piece):
		player1Queue.erase(piece)
	elif player2Queue.has(piece):
		player2Queue.erase(piece)

func resetGame():
	for player in players:
		player.queue_free()
	players.clear()
	player1Queue.clear()
	player2Queue.clear()

	_ready()

