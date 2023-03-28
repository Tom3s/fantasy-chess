extends Node2D

const Player := preload("res://Player.tscn")
const Board := preload("res://Board.tscn")
const GameController := preload("res://GameController.tscn")

var inputHandler: InputHandler
var gameController: GameController
var players: Array[Player]
var board: Board

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
		
	
	connectSignals()

	# Connect signals

func connectSignals():
	inputHandler.mouseClickedAt.connect(onInputHandler_mouseClickedAt)
	inputHandler.mouseMovedTo.connect(onInputHandler_mouseMoved)
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onInputHandler_mouseClickedAt(mousePosition: Vector2i):
	print("Observer: mouse clicked at: ", mousePosition)
	gameController.getCurrentPlayer().onSelectingTile(mousePosition, gameController.getAllOccupiedTiles(), gameController.getEnemyPlayerOccupiedTiles())

func onInputHandler_mouseMoved(mousePosition: Vector2i):
	board.setHoveringSquare(mousePosition)

func onPlayer_pieceSelected(piece: Piece):
	print("Observer: piece selected: ", piece)
	piece.onSelected()
	board.setReachableTiles(piece.move.getAvailableMoves(6, gameController.getAllOccupiedTiles()))
	board.setAttackableTiles(piece.move.getAvailableAttacks(gameController.getEnemyPlayerOccupiedTiles()))

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
	attackerPiece.onAttack()
	board.clearInteractableTiles()
	# gameController.nextPlayer()

func onPlayer_pieceDied(attackerPiece: Piece, deathPosition: Vector2i):
	print("Observer: piece died ", attackerPiece, " position ", deathPosition)
	attackerPiece.move.moveTo(deathPosition)

func onPlayer_turnEnded():
	print("Observer: turn ended")
	gameController.nextPlayer()
