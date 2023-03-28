extends Node2D

class_name Player

const Piece := preload("res://Piece.tscn")

enum STATES {
	WAITING_FOR_TURN,
	WAITING_FOR_PIECE_SELECTION,
	WAITING_FOR_MOVE_SELECTION
}

var state: STATES = STATES.WAITING_FOR_PIECE_SELECTION

var pieceColor: Color = Color.LIGHT_BLUE

var pieces: Array[Piece] = []

var piecesInPlay = [PieceNames.PAWN, PieceNames.PAWN, PieceNames.PAWN, PieceNames.PAWN, PieceNames.PAWN]

var currentlySelectedPiece: Piece = null
# signals
signal pieceSelected(piece: Piece)
signal pieceUnselected(piece: Piece)
signal pieceMoved(piece: Piece, position: Vector2i)
signal noPieceOnSelectedTile()
signal invalidTargetTile()
signal targetTileNotReachable()


func _ready():
	var index: int = 0
	for pieceName in piecesInPlay:
		var piece := Piece.instantiate()
		piece.init(pieceName, Vector2i(index, 0), pieceColor)
		add_child(piece)
		pieces.append(piece)

		index += 1


func onSelectingTile(tilePosition: Vector2i):
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
		# var availableMoves := currentlySelectedPiece.move.getAvailableMoves(6)
		if not GlobalVariables.isTilePositionValid(tilePosition):
			invalidTargetTile.emit()
		elif currentlySelectedPiece.move.getAvailableMoves(6).has(tilePosition):
			currentlySelectedPiece.move.moveTo(tilePosition)
			pieceMoved.emit(currentlySelectedPiece, tilePosition)
			state = STATES.WAITING_FOR_PIECE_SELECTION
			currentlySelectedPiece = null
		else:
			targetTileNotReachable.emit()
