extends Camera2D

class_name Camera

var _targetZoom: float = 0.35

@export_range(0.05, 0.2, 0.05)
var MIN_ZOOM: float = 0.15
@export_range(1.0, 5.0, 0.1)
var MAX_ZOOM: float = 3.0
const ZOOM_INCREMENT: float = 0.15
const ZOOM_RATE: float = 8.0
const CENTER_TIME: float = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	centerCamera()


func _process(delta):
	zoom = lerp(zoom, _targetZoom * Vector2.ONE, ZOOM_RATE * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("moveCamera"):
			position -= event.relative * (Vector2.ONE / zoom)
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("zoomCameraIn"):
			_zoomIn()
		elif event.is_action_pressed("zoomCameraOut"):
			_zoomOut()

func _zoomIn() -> void:
	_targetZoom = min(_targetZoom + ZOOM_INCREMENT, MAX_ZOOM)
	
func _zoomOut() -> void:
	_targetZoom = max(_targetZoom - ZOOM_INCREMENT, MIN_ZOOM)

func setCameraPosition(newPosition: Vector2) -> void:
	position = newPosition

func centerCamera() -> void:
	var targetCenter = Vector2(GlobalVariables.BOARD_WIDTH * GlobalVariables.GRID_SIZE / 2.0, GlobalVariables.BOARD_HEIGHT * GlobalVariables.GRID_SIZE / 2.0)
	create_tween().tween_property(self, "position", targetCenter, CENTER_TIME).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	_targetZoom = (get_viewport_rect().size.y * 0.9) / (GlobalVariables.GRID_SIZE * GlobalVariables.BOARD_HEIGHT)

func debugCameraPosition() -> String:
	return "Camera position: " + str(position)

func debugCameraZoom() -> String:
	return "Camera zoom: " + str(zoom)
