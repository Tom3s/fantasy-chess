extends Node2D

class_name PieceGraphic

const Graphic := preload("res://Graphic.tscn")

var graphic

func init(texturePath: String, pieceColor: Color):
	graphic = Graphic.instantiate()
	graphic.init(texturePath, pieceColor)
	add_child(graphic)

func setToSelected():
	graphic.select()

func setToUnselected():
	graphic.unSelect()
