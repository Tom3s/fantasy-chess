extends AnimatedSprite2D

class_name DiceFrames

var frames = [0, 1, 2, 3, 4, 5]

const ROTATION_LIMIT = 15

signal animationDone()
signal changedFrame()
signal arrivedAtMiddle()


func spinDice(finalValue: int):
	var tween = create_tween()
	var animFrames = []

	for i in 4:
		frames.shuffle()
		animFrames.append_array(frames)
	
	animFrames[-1] = finalValue

	for i in animFrames.size():
		var time = remap(i, 0, animFrames.size(), 0.005, 0.15)
		tween.tween_property(self, "frame", animFrames[i], 0.0) 
		# var basePosition = position
		# tween.tween_property(self, "position", basePosition - Vector2(0, 50), 0.0) 
		# var baseRotation = randi_range(-30, 30)

		# tween.tween_property(self, "rotation_degrees", randi_range(-ROTATION_LIMIT, ROTATION_LIMIT), 0.0)
		# tween.tween_property(self, "rotation_degrees", 0.0, time) 
		tween.tween_property(self, "rotation_degrees", rotation_degrees, time).from(randi_range(-ROTATION_LIMIT, ROTATION_LIMIT))

		tween.parallel().tween_property(self, "position", position, time).from(position - Vector2(0, 50)).finished.connect(nextFrame)
		# tween.tween_interval(time).finished.connect(nextFrame)
	
	tween.tween_interval(1.0).finished.connect(afterAnimation)
	# tween.finished.connect(afterAnimation)
	
func afterAnimation():
	print("Dice Rolling animation done")
	animationDone.emit()
	goToCorner()
	

func nextFrame():
	changedFrame.emit()


func goToMiddle():
	# var tween = create_tween()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)
	tween.parallel().tween_property(self, "position", get_viewport_rect().get_center(), 0.3).finished.connect(func(): arrivedAtMiddle.emit())

func goToCorner():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "scale", scale * 0.5, 0.5)

	var targetX = get_viewport_rect().size.x * 0.9
	var targetY = get_viewport_rect().size.y * 0.9

	tween.parallel().tween_property(self, "position", Vector2(targetX, targetY), 0.5)