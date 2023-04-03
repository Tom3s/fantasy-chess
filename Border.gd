extends Polygon2D

const BORDER_SIZE = 128

# Called when the node enters the scene tree for the first time.
func _ready():
	polygon = [
		Vector2(-BORDER_SIZE, -BORDER_SIZE),
		Vector2(-BORDER_SIZE, GlobalVariables.BOARD_WIDTH * GlobalVariables.GRID_SIZE + BORDER_SIZE),
		Vector2(GlobalVariables.BOARD_HEIGHT * GlobalVariables.GRID_SIZE + BORDER_SIZE, GlobalVariables.BOARD_WIDTH * GlobalVariables.GRID_SIZE + BORDER_SIZE),
		Vector2(GlobalVariables.BOARD_HEIGHT * GlobalVariables.GRID_SIZE + BORDER_SIZE, -BORDER_SIZE)
	]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
