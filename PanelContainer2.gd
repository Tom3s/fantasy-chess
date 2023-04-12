extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	size = get_viewport_rect().size
	scale = Vector2(3, 3)
	# pivot_offset = - get_viewport_rect().size * 2
	position = -get_viewport_rect().size * 1.5
	pass
