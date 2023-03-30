@tool
extends Node2D

class_name Board
# const GRID_SIZE = 256

@export
var width: int = GlobalVariables.BOARD_WIDTH:
	# set(newWidth): setWidth(newWidth)
	set(newWidth): 
		width = onWidthChanged(newWidth)
	get:
		return width

@export
var height: int = GlobalVariables.BOARD_HEIGHT:
	# set(newHeight): setHeight(newHeight)
	set(newHeight): 
		height = onHeightChanged(newHeight)
	get:
		return height

@export
var darkColor: Color = Color.DARK_CYAN
@export
var lightColor: Color = Color.LIGHT_SKY_BLUE

# var offsetX: int = int(width * GRID_SIZE / 2.0)
# var offsetY: int = int(height * GRID_SIZE / 2.0)
var offsetX: int = 0
var offsetY: int = 0

const padding = 5
var hoveringSquare: Vector2i = Vector2i(-1, -1)
var reachableTiles: Array[Vector2i] = []
var attackableTiles: Array[Vector2i] = []

# signal readyToChangeCamera()

# func _init():
# 	readyToChangeCamera.emit()

func _draw() -> void:
	for i in range(width):
		for j in range(height):
			var colorIndex = (i + j) % 2
			var currentColor = lightColor if colorIndex == 0 else darkColor
			var posX = i * GlobalVariables.GRID_SIZE - offsetX
			var posY = j * GlobalVariables.GRID_SIZE - offsetY
			
			draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE, GlobalVariables.GRID_SIZE), currentColor)
	
	
	for tile in reachableTiles:
		var posX = tile.x * GlobalVariables.GRID_SIZE - offsetX # + padding
		var posY = tile.y * GlobalVariables.GRID_SIZE - offsetY # + padding
		
		# draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE - padding*2, GlobalVariables.GRID_SIZE - padding*2), Color.DARK_OLIVE_GREEN, false, padding * 2)
		draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE, GlobalVariables.GRID_SIZE), Color(0.0, 0.8, 0.2, 0.5))
	
	
	for tile in attackableTiles:
		var posX = tile.x * GlobalVariables.GRID_SIZE - offsetX # + padding
		var posY = tile.y * GlobalVariables.GRID_SIZE - offsetY # + padding
		
		# draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE - padding*2, GlobalVariables.GRID_SIZE - padding*2), Color.DARK_OLIVE_GREEN, false, padding * 2)
		draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE, GlobalVariables.GRID_SIZE), Color(0.8, 0.1, 0.2, 0.5))
	
	if hoveringSquare != Vector2i(-1, -1):
		var posX = hoveringSquare.x * GlobalVariables.GRID_SIZE - offsetX + padding
		var posY = hoveringSquare.y * GlobalVariables.GRID_SIZE - offsetY + padding
		
		draw_rect(Rect2(posX, posY, GlobalVariables.GRID_SIZE - padding*2, GlobalVariables.GRID_SIZE - padding*2), Color.BLACK, false, padding * 2)
		

func setHeight(newHeight: int) -> void:
	height = onHeightChanged(newHeight)
	
func setWidth(newWidth: int) -> void:
	width = onWidthChanged(newWidth)

func onHeightChanged(newHeight: int) -> int:
	queue_redraw()
	GlobalVariables.setBoardDimensions(width, newHeight)
	return newHeight

func onWidthChanged(newWidth: int) -> int:
	queue_redraw()
	GlobalVariables.setBoardDimensions(newWidth, height)
	return newWidth

func setHoveringSquare(pos: Vector2i) -> void:
	
	if GlobalVariables.isTilePositionValid(pos):
		hoveringSquare = pos
	else:
		hoveringSquare = Vector2i(-1, -1)
	
	queue_redraw()

func setReachableTiles(tiles: Array[Vector2i]) -> void:
	
	reachableTiles = tiles.filter(GlobalVariables.isTilePositionValid)
	queue_redraw()

func setAttackableTiles(tiles: Array[Vector2i]) -> void:
	
	attackableTiles = tiles.filter(GlobalVariables.isTilePositionValid)
	queue_redraw()

func clearInteractableTiles() -> void:
	reachableTiles.clear()
	attackableTiles.clear()
	queue_redraw()

func debugReachableTiles() -> String:
	return "Reachable tiles: " + str(reachableTiles)

