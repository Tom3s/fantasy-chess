extends Node2D

const Player := preload("res://Player.tscn")
const Board := preload("res://Board.tscn")
const GameController := preload("res://GameController.tscn")

var inputHandler: InputHandler
var gameController: GameController
var players: Array[Player]
var board: Board
var camera: Camera2D
var dice: Dice
var debugScreen: DebugScreen
var mouseHover: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	inputHandler = %InputHandler
	if inputHandler == null:
		push_warning("InputHandler is null in Observer")
	
	gameController = %GameController
	if gameController == null:
		push_warning("GameController is null in Observer")

	players = gameController.getAllPlayers()
	# player = $"../Player"
	# if player == null:
	# 	push_warning("Player is null in Observer")
		

	board = $"../Board"
	if board == null:
		push_warning("Board is null in Observer")
	
	camera = %Camera2D
	dice = %Dice
	debugScreen = %DebugScreen

	mouseHover = %MouseHover

	connectSignals()
	connectPlayerSignals()

	# Connect signals

func connectSignals():
	inputHandler.mouseClickedAt.connect(onInputHandler_mouseClickedAt)
	inputHandler.mouseMovedTo.connect(onInputHandler_mouseMoved)
	inputHandler.centerCameraPressed.connect(onInputHandler_centerCameraPressed)
	inputHandler.resetGamePressed.connect(onInputHandler_resetGamePressed)
	inputHandler.fullScreenPressed.connect(onInputHandler_fullScreenPressed)
	inputHandler.toggleDebugPressed.connect(onInputHandler_toggleDebugPressed)
	gameController.waitingForRoll.connect(onGameController_waitingForRoll)
	dice.atMiddle.connect(onDice_atMiddle)
	dice.finishedRoll.connect(onDice_finishedRoll)

func connectPlayerSignals():
	for player in players:
		player.pieceSelected.connect(onPlayer_pieceSelected)
		player.pieceMoved.connect(onPlayer_pieceMoved)
		player.noPieceOnSelectedTile.connect(onPlayer_noPieceOnSelectedTile)
		player.pieceUnselected.connect(onPlayer_pieceUnselected)
		player.invalidTargetTile.connect(onPlayer_invalidTargetTile)
		player.targetTileNotReachable.connect(onPlayer_targetTileNotReachable)
		player.pieceAttacked.connect(onPlayer_pieceAttacked)
		player.pieceDied.connect(onPlayer_pieceDied)
		player.turnEnded.connect(onPlayer_turnEnded)
		player.pieceTookDamage.connect(onPlayer_pieceTookDamage)
	# board.readyToChangeCamera.connect(onBoard_readyToChangeCamera)


func onInputHandler_mouseClickedAt(mousePosition: Vector2i):
	print("Observer: mouse clicked at: ", mousePosition)
	gameController.getCurrentPlayer().onSelectingTile(mousePosition, gameController.currentRoll, gameController.getAllOccupiedTiles(), gameController.getEnemyPlayerOccupiedTiles())

func onInputHandler_mouseMoved(mousePosition: Vector2i):
	board.setHoveringSquare(mousePosition)
	mouseHover.setText(gameController.getEnemyPieceAt(mousePosition))


func onPlayer_pieceSelected(piece: Piece):
	print("Observer: piece selected: ", piece)
	piece.onSelected()
	var availableAttacks := piece.move.getAvailableAttacks(gameController.currentRoll, gameController.getEnemyPlayerOccupiedTiles(), gameController.getAllOccupiedTiles())
	board.setReachableTiles(piece.move.getAvailableMoves(gameController.currentRoll, gameController.getAllOccupiedTiles()))
	board.setAttackableTiles(availableAttacks)
	mouseHover.setAttacks(piece, availableAttacks)

func onPlayer_pieceUnselected(piece: Piece):
	print("Observer: piece unselected: ", piece)
	piece.onUnselected()
	board.clearInteractableTiles()
	
func onPlayer_pieceMoved(piece: Piece, newPosition: Vector2i):
	print("Observer: piece moved: ", piece, " to ", newPosition)
	piece.onMoved()
	board.clearInteractableTiles()
	# gameController.nextPlayer()

func onPlayer_noPieceOnSelectedTile():
	print("Observer: no piece on selected tile")

func onPlayer_invalidTargetTile():
	print("Observer: invalid target tile")
	
func onPlayer_targetTileNotReachable():
	print("Observer: target tile not reachable")

func onPlayer_pieceAttacked(attackerPiece: Piece, attackedPosition: Vector2i):
	print("Observer: piece attacked ", attackerPiece, " position ", attackedPosition)
	gameController.getEnemyPlayer().takeDamageAtTile(attackerPiece, attackedPosition)
	board.clearInteractableTiles()

func onPlayer_pieceDied(attackerPiece: Piece, deathPosition: Vector2i):
	print("Observer: piece died ", attackerPiece, " position ", deathPosition)
	attackerPiece.onKill(deathPosition)

func onPlayer_pieceTookDamage(attackerPiece: Piece, attackedPosition: Vector2i):
	print("Observer: piece took damage ", attackerPiece, " position ", attackedPosition)
	attackerPiece.onAttack(attackedPosition, gameController.getAllOccupiedTiles())

func onPlayer_turnEnded():
	print("Observer: turn ended")
	var empty: Array[Vector2i] = [] 
	mouseHover.setAttacks(null, empty)
	mouseHover.clearText()
	gameController.nextPlayer()


func onInputHandler_centerCameraPressed():
	print("Observer: center camera pressed")
	camera.centerCamera()

func onInputHandler_resetGamePressed():
	print("Observer: reset game pressed")
	gameController.resetGame()
	camera.centerCamera()
	players = gameController.getAllPlayers()
	connectPlayerSignals()

func onGameController_waitingForRoll():
	print("Observer: waiting for roll")
	dice.getReadyToRoll()

func onDice_atMiddle():
	print("Observer: dice at middle")
	gameController.currentRoll = dice.rollDice(gameController.currentPlayerIndex)
	

func onDice_finishedRoll():
	print("Observer: dice finished roll")
	gameController.startCurrentPlayerTurn()

func onInputHandler_fullScreenPressed():
	print("Observer: full screen pressed")
	var nextWindowMode = DisplayServer.window_get_mode()
	if nextWindowMode == DisplayServer.WINDOW_MODE_WINDOWED:
		nextWindowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
	else:
		nextWindowMode = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(nextWindowMode)

func onInputHandler_toggleDebugPressed():
	print("Observer: toggle debug pressed")
	debugScreen.toggleDebugScreen()
