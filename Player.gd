extends Node2D

class_name Player

const Piece := preload("res://Piece.tscn")

enum STATES {
	WAITING_FOR_TURN,
	WAITING_FOR_PIECE_SELECTION,
	WAITING_FOR_MOVE_SELECTION
}

var state: STATES = STATES.WAITING_FOR_TURN

var playerName: String

var pieceColor: Color = Color.LIGHT_BLUE

var pieces: Array[Piece] = []

var piecesInPlay: Array[String]

var currentlySelectedPiece: Piece = null
# signals
signal pieceSelected(piece: Piece)
signal pieceUnselected(piece: Piece)
signal pieceMoved(piece: Piece, position: Vector2i)
signal pieceAttacked(piece: Piece, position: Vector2i)
signal noPieceOnSelectedTile()
signal invalidTargetTile()
signal targetTileNotReachable()
signal pieceDied(attacker: Piece, position: Vector2i)
signal pieceTookDamage(attacker: Piece, position: Vector2i)
signal turnEnded()

func init(initialName: String, initialPieceColor: Color, startingRow: int, piecesToPlay: Array[String]):
	# print("default pieces: ", defaultPieces)
	# piecesToPlay = [PieceNames.EMPTY, PieceNames.PAWN, PieceNames.EMPTY, PieceNames.BISHOP, PieceNames.BISHOP, PieceNames.EMPTY, PieceNames.PAWN]
	playerName = initialName
	pieceColor = initialPieceColor
	print("pieces to play: ", piecesToPlay)
	piecesInPlay = piecesToPlay
	print("pieces in play: ", piecesInPlay)
	
	var index: int = 0
	for pieceName in piecesInPlay:
		if pieceName == PieceNames.EMPTY:
			index += 1
			continue
		var piece := Piece.instantiate()
		piece.init(pieceName, Vector2i(index, startingRow), pieceColor)
		add_child(piece)
		pieces.append(piece)

		index += 1
	

func _ready():
	pass

func onSelectingTile(tilePosition: Vector2i, allOccupiedTiles: Array[Vector2i], enemyOccupiedTiles: Array[Vector2i]):
	if state == STATES.WAITING_FOR_PIECE_SELECTION:
		for piece in pieces:
			print(piece, " position: ", piece.move.localPosition)
			if piece.move.localPosition == tilePosition:
				currentlySelectedPiece = piece
				pieceSelected.emit(piece)
				state = STATES.WAITING_FOR_MOVE_SELECTION
				return
		noPieceOnSelectedTile.emit()

	elif state == STATES.WAITING_FOR_MOVE_SELECTION:
		if currentlySelectedPiece != null:
			if currentlySelectedPiece.move.localPosition == tilePosition:
				# deselect piece
				state = STATES.WAITING_FOR_PIECE_SELECTION
				pieceUnselected.emit(currentlySelectedPiece)
				currentlySelectedPiece = null
				return
		
		
		# outside of board clicked
		if not GlobalVariables.isTilePositionValid(tilePosition):
			invalidTargetTile.emit()
		# reachable tile clicked
		elif currentlySelectedPiece.move.getAvailableMoves(6, allOccupiedTiles).has(tilePosition):
			currentlySelectedPiece.move.moveTo(tilePosition)
			pieceMoved.emit(currentlySelectedPiece, tilePosition)
			state = STATES.WAITING_FOR_TURN
			turnEnded.emit()
			currentlySelectedPiece = null
		# attackable tile clicked
		elif currentlySelectedPiece.move.getAvailableAttacks(enemyOccupiedTiles, allOccupiedTiles).has(tilePosition):
			pieceAttacked.emit(currentlySelectedPiece, tilePosition)
			state = STATES.WAITING_FOR_TURN
			turnEnded.emit()
			currentlySelectedPiece = null
		# unreachable tile clicked
		else:
			targetTileNotReachable.emit()

func startTurn():
	state = STATES.WAITING_FOR_PIECE_SELECTION

func getOccupiedTiles() -> Array[Vector2i]:
	var occupiedTiles: Array[Vector2i] = []
	for piece in pieces:
		occupiedTiles.append(piece.move.localPosition)
	return occupiedTiles

func takeDamageAtTile(attackerPiece: Piece, tilePosition: Vector2i):
	for piece in pieces:
		if piece.move.localPosition == tilePosition:
			piece.health.takeDamage(attackerPiece.attackStrength)
			if piece.health.isDead():
				pieces.erase(piece)
				piece.queue_free()
				pieceDied.emit(attackerPiece, tilePosition)
			else:
				pieceTookDamage.emit(attackerPiece, tilePosition)
			break




