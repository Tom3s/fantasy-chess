extends Node2D

class_name Dice

var roll: int
var displayedValue: int

var diceSprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	diceSprite = %Frames


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateNewRoll():
	return randi_range(0, 5)

func rollDice():
	roll = generateNewRoll()
	diceSprite.spinDice(roll)
	print("Rolled a " + str(roll + 1))




func _input(event: InputEvent):
	if event.is_action_pressed("centerCamera"):
		rollDice()
