@tool
extends Node2D

class_name PawnPromotionSelector

var parentPiece: Piece

signal promotionPieceSelected(piece: String, parent: Piece)

func init(piece: Piece):
	parentPiece = piece
	print("Promotion Selector initialized")
	pass

func _process(delta):
	position = get_viewport_rect().get_center()

func _unhandled_input(event: InputEvent):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_1:
			finish(PieceNames.QUEEN)
		elif event.is_pressed() and event.keycode == KEY_2:
			finish(PieceNames.ROOK)
		elif event.is_pressed() and event.keycode == KEY_3:
			finish(PieceNames.BISHOP)
		elif event.is_pressed() and event.keycode == KEY_4:
			finish(PieceNames.KNIGHT)

func finish(piece: String):
	print("Promoting to " + piece)
	promotionPieceSelected.emit(piece, parentPiece)
	queue_free()
