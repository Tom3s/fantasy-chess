extends Camera2D

var _targetZoom: float = 0.35

@export_range(0.05, 0.2, 0.05)
var MIN_ZOOM: float = 0.15
@export_range(1.0, 5.0, 0.1)
var MAX_ZOOM: float = 3.0
const ZOOM_INCREMENT: float = 0.15
const ZOOM_RATE: float = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zoom = lerp(zoom, _targetZoom * Vector2.ONE, ZOOM_RATE * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
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
