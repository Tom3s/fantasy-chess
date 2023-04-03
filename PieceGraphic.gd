extends Node2D

class_name PieceGraphic

const Graphic := preload("res://Graphic.tscn")

signal attackAnimationDone(finalPosition: Vector2i)

var graphic

func init(texturePath: String, pieceColor: Color):
	graphic = Graphic.instantiate()
	graphic.init(texturePath, pieceColor)
	add_child(graphic)

func setToSelected():
	graphic.select()

func setToUnselected():
	graphic.unSelect()

func playAttack(parent: Piece, targetPosition: Vector2i, finalPosition: Vector2i):
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	var attackTweenOffset = (parent.position - Vector2(targetPosition) * GlobalVariables.GRID_SIZE).normalized()
	var attackTweenPosition = Vector2(targetPosition) * GlobalVariables.GRID_SIZE + attackTweenOffset * GlobalVariables.GRID_SIZE * 0.5
	tween.tween_property(parent, "position", attackTweenPosition, 0.2).finished.connect(func(): attackAnimationDone.emit(finalPosition))
	# tween.tween_property(parent, "position", Vector2(finalPosition) * GlobalVariables.GRID_SIZE, 0.3).set_ease(Tween.EASE_OUT).finished.connect(func(): attackAnimationDone.emit())

func playDamageTaken():
	graphic.damageTaken()
