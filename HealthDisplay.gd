extends Label

var healthSource: Callable = Callable(self, "placeHolder")
var isReady := false

var font_size = 30

func init(source: Callable):
	healthSource = source

	isReady = true
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isReady:
		self.text = "Health: " + str(healthSource.call())
		
func setOffset(offset: Vector2):
	offset_left = offset.x
	offset_top = offset.y
	pass
	
func placeHolder():
	return randi_range(0, 100)
