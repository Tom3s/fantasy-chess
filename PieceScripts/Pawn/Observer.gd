extends Node2D

const Player := preload("res://Player.tscn")
const Board := preload("res://Board.tscn")

var inputHandler: InputHandler
var player: Player
var board: Board

# Called when the node enters the scene tree for the first time.
func _ready():
	inputHandler = %InputHandler
	if inputHandler == null:
		push_warning("InputHandler is null in Observer")
		

	player = $"../Player"
	if player == null:
		push_warning("Player is null in Observer")
		

	board = $"../Board"
	if board == null:
		push_warning("Board is null in Observer")
		
	
	connectSignals()

	# Connect signals

func connectSignals():
	inputHandler.mouseClickedAt.connect(onInputHandler_mouseClickedAt)
	inputHandler.mouseMovedTo.connect(onInputHandler_mouseMoved)
	player.pieceSelected.connect(onPlayer_pieceSelected)
	player.pieceMoved.connect(onPlayer_pieceMoved)
	player.noPieceOnSelectedTile.connect(onPlayer_noPieceOnSelectedTile)
	player.pieceUnselected.connect(onPlayer_pieceUnselected)
	player.invalidTargetTile.connect(onPlayer_invalidTargetTile)
	player.targetTileNotReachable.connect(onPlayer_targetTileNotReachable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onInputHandler_mouseClickedAt(mousePosition: Vector2i):
	print("Observer: mouse clicked at: ", mousePosition)
	player.onSelectingTile(mousePosition)

func onInputHandler_mouseMoved(mousePosition: Vector2i):
	board.setHoveringSquare(mousePosition)

func onPlayer_pieceSelected(piece: Piece):
	print("Observer: piece selected: ", piece)
	piece.onSelected()
	board.setReachableTiles(piece.move.getAvailableMoves(6))

func onPlayer_pieceUnselected(piece: Piece):
	print("Observer: piece unselected: ", piece)
	piece.onUnselected()
	board.clearReachableTiles()
	
func onPlayer_pieceMoved(piece: Piece, position: Vector2i):
	print("Observer: piece moved: ", piece, " to ", position)
	piece.onMoved()
	board.clearReachableTiles()

func onPlayer_noPieceOnSelectedTile():
	print("Observer: no piece on selected tile")

func onPlayer_invalidTargetTile():
	print("Observer: invalid target tile")
	
func onPlayer_targetTileNotReachable():
	print("Observer: target tile not reachable")