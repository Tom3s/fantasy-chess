@tool
extends ProgressBar

var healthSource: Callable = Callable(self, "placeHolder")
var healthMax: Callable = Callable(self, "placeHolder")

var textChild: HealthText

func init(source: Callable, getMax: Callable):
	healthSource = source
	healthMax = getMax

	max_value = getMax.call()

	size = Vector2(180, 26)
	position = Vector2(38, 250)

	textChild = %HealthText

	update()

func setOffset(offset: Vector2):
	offset_left = offset.x
	offset_top = offset.y
	pass
	
func placeHolder():
	return randi_range(0, 100)

func update():
	value = healthSource.call()
	textChild.setText(value, max_value)