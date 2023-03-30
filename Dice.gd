extends Node2D

class_name Dice

var roll: int
var displayedValue: int

var diceSprite: DiceFrames

signal atMiddle()
signal finishedRoll()

# Called when the node enters the scene tree for the first time.
func _ready():
	diceSprite = %Frames
	
	diceSprite.arrivedAtMiddle.connect(func(): atMiddle.emit())
	diceSprite.animationDone.connect(func(): finishedRoll.emit())

	diceSprite.goToCorner()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateNewRoll():
	return randi_range(0, 5)

func rollDice() -> int:
	roll = generateNewRoll()
	diceSprite.spinDice(roll)
	print("Rolled a " + str(roll + 1))
	return roll + 1

func getReadyToRoll():
	diceSprite.goToMiddle()

# func _input(event: InputEvent):
# 	if event.is_action_pressed("centerCamera"):
# 		position = get_viewport_rect().size / 2
# 		rollDice()
