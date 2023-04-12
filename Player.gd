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

# var piecesInPlay: Array[String]

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

func init(initialName: String, initialPieceColor: Color, startingRow: int, mainRow: Array[String], secondaryRow: Array[String]):
	playerName = initialName
	pieceColor = initialPieceColor
	# piecesInPlay = mainRow
	# piecesInPlay.append_array(secondaryRow)

	var startedAtTop := startingRow == 0
	
	var index: int = 0
	for pieceName in mainRow:
		if pieceName == PieceNames.EMPTY:
			index += 1
			continue
		var piece := Piece.instantiate()
		add_child(piece)
		piece.init(pieceName, Vector2i(index, startingRow), pieceColor, startedAtTop)
		pieces.append(piece)

		index += 1
	
	
	var pawnRow = startingRow + 1
	if startingRow != 0:
		pawnRow = startingRow - 1
	

	index = 0
	for pieceName in secondaryRow:
		if pieceName == PieceNames.EMPTY:
			index += 1
			continue
		var piece := Piece.instantiate()
		add_child(piece)
		piece.init(pieceName, Vector2i(index, pawnRow), pieceColor, startedAtTop)
		pieces.append(piece)

		index += 1

func _ready():
	pass

func onSelectingTile(tilePosition: Vector2i, maxCost: int,  allOccupiedTiles: Array[Vector2i], enemyOccupiedTiles: Array[Vector2i]):
	if state == STATES.WAITING_FOR_PIECE_SELECTION:
		for piece in pieces:
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
			else:
				# select another piece
				for piece in pieces:
					if piece.move.localPosition == tilePosition:
						pieceUnselected.emit(currentlySelectedPiece)
						currentlySelectedPiece = piece
						pieceSelected.emit(piece)
						return
		
		
		# outside of board clicked
		if not GlobalVariables.isTilePositionValid(tilePosition):
			invalidTargetTile.emit()
		# reachable tile clicked
		elif currentlySelectedPiece.move.getAvailableMoves(maxCost, allOccupiedTiles).has(tilePosition):
			currentlySelectedPiece.move.moveTo(tilePosition)
			pieceMoved.emit(currentlySelectedPiece, tilePosition)
			state = STATES.WAITING_FOR_TURN
			turnEnded.emit()
			currentlySelectedPiece = null
		# attackable tile clicked
		elif currentlySelectedPiece.move.getAvailableAttacks(maxCost, enemyOccupiedTiles, allOccupiedTiles).has(tilePosition):
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

func usePieceAbility():
	if currentlySelectedPiece != null:
		currentlySelectedPiece.abilityUsed.connect(onPieceAbilityUsed)
		currentlySelectedPiece.onUseAbility()
		

func onPieceAbilityUsed():
	pieceUnselected.emit(currentlySelectedPiece)
	currentlySelectedPiece = null
	state = STATES.WAITING_FOR_TURN
	turnEnded.emit()



