extends Node2D

class_name GameController

const Player := preload("res://Player.tscn")

var players: Array[Player]

var currentPlayerIndex: int

var defaultPieces: Array[String] = [PieceNames.KNIGHT, PieceNames.KNIGHT, PieceNames.ROOK, PieceNames.ROOK, PieceNames.BISHOP, PieceNames.BISHOP, PieceNames.QUEEN, PieceNames.PAWN, PieceNames.PAWN]

var currentRoll = 0

signal waitingForRoll()

# Called when the node enters the scene tree for the first time.
func _ready():
	# player1
	var player1Pieces = getRandomMainRow()
	var player := Player.instantiate()
	add_child(player)
	player.init("Pink", Color.MEDIUM_VIOLET_RED, 0, player1Pieces, getRandomSecondaryRow(player1Pieces))
	players.append(player)

	# player2
	var player2Pieces = getRandomMainRow()
	player = Player.instantiate()
	add_child(player)
	player.init("Blue", Color.DEEP_SKY_BLUE, GlobalVariables.BOARD_HEIGHT - 1, player2Pieces, getRandomSecondaryRow(player2Pieces))
	players.append(player)

	currentPlayerIndex = 0

	waitingForRoll.emit()

func getRandomMainRow() -> Array[String]:
	var mainRow = defaultPieces.duplicate()
	mainRow.shuffle()
	var firstBishopIndex = mainRow.find(PieceNames.BISHOP)
	var secondBishopIndex = mainRow.find(PieceNames.BISHOP, firstBishopIndex + 1)

	while firstBishopIndex % 2 == secondBishopIndex % 2:
		mainRow.shuffle()
		firstBishopIndex = mainRow.find(PieceNames.BISHOP)
		secondBishopIndex = mainRow.find(PieceNames.BISHOP, firstBishopIndex + 1)
	
	return mainRow

func getRandomSecondaryRow(mainRow: Array[String]) -> Array[String]:
	var secondaryRow: Array[String] = []

	for i in mainRow.size():
		if (mainRow[i] == PieceNames.BISHOP) or (mainRow[i] == PieceNames.KNIGHT):
			secondaryRow.append(PieceNames.PAWN)
		else:
			secondaryRow.append(PieceNames.EMPTY)
	
	print("Secondary row: " + str(secondaryRow))
	return secondaryRow

func getAllPlayers() -> Array[Player]:
	return players

func getCurrentPlayer() -> Player:
	return players[currentPlayerIndex]

func getEnemyPlayer() -> Player:
	var enemyPlayerIndex := (currentPlayerIndex + 1) % players.size()
	return players[enemyPlayerIndex]

func nextPlayer():
	currentPlayerIndex = (currentPlayerIndex + 1) % players.size()
	waitingForRoll.emit()
	# players[currentPlayerIndex].startTurn()

func startCurrentPlayerTurn():
	players[currentPlayerIndex].startTurn()

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

func getEnemyPieceAt(tile: Vector2i) -> Piece:
	var enemyPlayerIndex := (currentPlayerIndex + 1) % players.size()
	var enemyPiece = players[enemyPlayerIndex].pieces.filter(func(a: Piece): return a.move.localPosition == tile)
	# print("Enemy piece at " + str(tile) + ": " + str(enemyPiece))
	return enemyPiece.front() if enemyPiece.size() > 0 else null

func resetGame():
	for player in players:
		player.queue_free()
	players.clear()
		
	_ready()

