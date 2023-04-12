extends Node2D

class_name InputHandler

var localMousePosition: Vector2i

# listen for mouse clicks
signal mouseClickedAt(position: Vector2i)
signal mouseMovedTo(position: Vector2i)
signal centerCameraPressed()
signal resetGamePressed()
signal fullScreenPressed()
signal toggleDebugPressed()

# func _ready():
# 	# listen for mouse clicks
# 	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# 	Input.set_use_accumulated_input(false)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var newMousePosition = convertGlobalMousePositionToLocal(get_global_mouse_position())
		if newMousePosition != localMousePosition:
			localMousePosition = convertGlobalMousePositionToLocal(get_global_mouse_position())
			mouseMovedTo.emit(localMousePosition)
	if event is InputEventMouseButton:
		if event.is_action_pressed("selectTile"):
			mouseClickedAt.emit(localMousePosition)
	
	if event is InputEventKey:
		if event.is_action_pressed("centerCamera"):
			centerCameraPressed.emit()
		if event.is_action_pressed("resetGame"):
			resetGamePressed.emit()
		if event.is_action_pressed("fullScreen"):
			fullScreenPressed.emit()
		if event.is_action_pressed("toggleDebug"):
			toggleDebugPressed.emit()

func convertGlobalMousePositionToLocal(globalPosition: Vector2) -> Vector2i:
	
	var localX := floori(globalPosition.x / GlobalVariables.GRID_SIZE)
	var localY := floori(globalPosition.y / GlobalVariables.GRID_SIZE)

	return Vector2i(localX, localY)

func debugLocalMousePosition() -> String:
	return "Local Mouse Position: " + str(localMousePosition)
