extends Button

class_name UseAbilityButton

# Called when the node enters the scene tree for the first time.
func _ready():
	updatePosition()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updatePosition():

	var newScale = 1.5 * get_viewport_rect().size.y / 1080

	scale = Vector2.ONE * newScale

	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

	var targetX = get_viewport_rect().size.x * 0.85
	var targetY = get_viewport_rect().size.y * 0.05

	tween.parallel().tween_property(self, "position", Vector2(targetX, targetY), 0.5)
