extends ProgressBar

var healthSource: Callable = Callable(self, "placeHolder")
var healthMax: Callable = Callable(self, "placeHolder")

func init(source: Callable, max: Callable):
	healthSource = source
	healthMax = max

	max_value = max.call()

	size = Vector2(180, 26)
	position = Vector2(38, 250)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if isReady:
	# 	self.text = "Health: " + str(healthSource.call())
	value = healthSource.call()
	pass
		
func setOffset(offset: Vector2):
	offset_left = offset.x
	offset_top = offset.y
	pass
	
func placeHolder():
	return randi_range(0, 100)
