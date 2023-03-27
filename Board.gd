extends Node2D

const GRID_SIZE = 256

@export
var width: int = 10
@export
var height: int = 10
@export
var darkColor: Color = Color.DARK_CYAN
@export
var lightColor: Color = Color.LIGHT_SKY_BLUE

var offsetX: int = int(width * GRID_SIZE / 2.0)
var offsetY: int = int(height * GRID_SIZE / 2.0)

func _draw() -> void:
	for i in range(width):
		for j in range(height):
			var colorIndex = (i + j) % 2
			var currentColor = lightColor if colorIndex == 0 else darkColor
			var posX = i * GRID_SIZE - offsetX
			var posY = j * GRID_SIZE - offsetY
			
			draw_rect(Rect2(posX, posY, GRID_SIZE, GRID_SIZE), currentColor)