extends Node2D

class_name GameController

const Player := preload("res://Player.tscn")

var players: Array[Player]

var currentPlayerIndex: int


# Called when the node enters the scene tree for the first time.
func _ready():
	# player1
	var player := Player.instantiate()
	player.init("Cyan", Color.CYAN, 0)
	add_child(player)
	players.append(player)

	# player2
	player = Player.instantiate()
	player.init("Orange", Color.CORAL, GlobalVariables.BOARD_HEIGHT - 1)
	add_child(player)
	players.append(player)

	currentPlayerIndex = 0

	players[currentPlayerIndex].startTurn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getAllPlayers() -> Array[Player]:
	return players

func nextPlayer():
	currentPlayerIndex = (currentPlayerIndex + 1) % players.size()
	players[currentPlayerIndex].startTurn()

func debugCurrentPlayer() -> String:
	return "Current player: " + str(currentPlayerIndex) + " - " + players[currentPlayerIndex].playerName


