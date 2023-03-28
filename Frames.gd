extends AnimatedSprite2D

class_name DiceFrames

var frames = [0, 1, 2, 3, 4, 5]

const ROTATION_LIMIT = 15

signal animationDone()
signal changedFrame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spinDice(finalValue: int):
	var tween = create_tween()
	var animFrames = []

	for i in 4:
		frames.shuffle()
		animFrames.append_array(frames)
	



	for i in animFrames.size():
		var time = remap(i, 0, animFrames.size(), 0.005, 0.15)
		tween.tween_property(self, "frame", animFrames[i], 0.0) 
		var basePosition = position
		tween.tween_property(self, "position", basePosition - Vector2(0, 50), 0.0) 
		# var baseRotation = randi_range(-30, 30)
		tween.tween_property(self, "rotation_degrees", randi_range(-ROTATION_LIMIT, ROTATION_LIMIT), 0.0)
		tween.tween_property(self, "rotation_degrees", 0.0, time) 
		tween.parallel().tween_property(self, "position", basePosition, time).finished.connect(nextFrame)
		# tween.tween_interval(time).finished.connect(nextFrame)

	tween.tween_property(self, "frame", finalValue, 0.0)
	tween.finished.connect(afterAnimation)
	
func afterAnimation():
	print("Dice Rolling animation done")
	animationDone.emit()

func nextFrame():
	changedFrame.emit()
	# print("next frame")
