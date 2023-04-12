extends Polygon2D

class_name Border

const BORDER_SIZE = 128

# Called when the node enters the scene tree for the first time.
func _ready():
	polygon = [
		Vector2(-BORDER_SIZE, -BORDER_SIZE),
		Vector2(-BORDER_SIZE, GlobalVariables.BOARD_HEIGHT * GlobalVariables.GRID_SIZE + BORDER_SIZE),
		Vector2(GlobalVariables.BOARD_WIDTH * GlobalVariables.GRID_SIZE + BORDER_SIZE, GlobalVariables.BOARD_HEIGHT * GlobalVariables.GRID_SIZE + BORDER_SIZE),
		Vector2(GlobalVariables.BOARD_WIDTH * GlobalVariables.GRID_SIZE + BORDER_SIZE, -BORDER_SIZE)
	]
	pass # Replace with function body.

func updateColor(newColor: Color):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	# color = newColor
	tween.tween_property(self, "color", newColor, 0.5)
