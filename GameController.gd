extends Node2D

class_name GameController

const Player := preload("res://Player.tscn")

var players: Array[Player]

var currentPlayerIndex: int

var defaultPieces: Array[String] = [PieceNames.PAWN, PieceNames.BISHOP, PieceNames.BISHOP, PieceNames.PAWN]


# Called when the node enters the scene tree for the first time.
func _ready():
	# player1
	var player := Player.instantiate()
	player.init("Cyan", Color.CYAN, 0, defaultPieces)
	add_child(player)
	players.append(player)

	# player2
	player = Player.instantiate()
	player.init("Orange", Color.CORAL, GlobalVariables.BOARD_HEIGHT - 1, defaultPieces)
	add_child(player)
	players.append(player)

	currentPlayerIndex = 0

	players[currentPlayerIndex].startTurn()


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


