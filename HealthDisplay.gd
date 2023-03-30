extends ProgressBar

var healthSource: Callable = Callable(self, "placeHolder")
var healthMax: Callable = Callable(self, "placeHolder")

func init(source: Callable, getMax: Callable):
	healthSource = source
	healthMax = getMax

	max_value = getMax.call()

	size = Vector2(180, 26)
	position = Vector2(38, 250)
	pass

func _process(delta):
	value = healthSource.call()
	pass
		
func setOffset(offset: Vector2):
	offset_left = offset.x
	offset_top = offset.y
	pass
	
func placeHolder():
	return randi_range(0, 100)
