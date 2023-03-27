extends Node

class_name PieceGraphic

const healtBarPosition := Vector2i(128, 10)

var graphic

func init(graphicPath: String):
	graphic = load(graphicPath).instantiate()
	graphic.z_index = -1
	add_child(graphic)

func setToSelected():
	graphic.select()

func setToUnselected():
	graphic.unSelect()
