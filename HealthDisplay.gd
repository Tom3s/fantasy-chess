extends Label

var healthSource: Callable = Callable(self, "placeHolder")

func init(source: Callable):
	healthSource = source
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Health: " + str(healthSource.call())
		
func setOffset(offset: Vector2):
	offset_left = offset.x
	offset_top = offset.y
	pass
	
func placeHolder():
	return randi_range(0, 100)
