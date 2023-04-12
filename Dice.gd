extends Node2D

class_name Dice

var roll: int
var displayedValue: int

var diceSprite: DiceFrames

signal atMiddle()
signal finishedRoll()

var bagOfValues := [0, 1, 2, 3, 4, 5]

var bags = [[],[]]

# Called when the node enters the scene tree for the first time.
func _ready():
	diceSprite = %Frames
	
	diceSprite.arrivedAtMiddle.connect(func(): atMiddle.emit())
	diceSprite.animationDone.connect(func(): finishedRoll.emit())

	diceSprite.goToCorner()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateNewRoll(playerIndex: int):
	if bags[playerIndex].size() == 0:
		bags[playerIndex] = bagOfValues.duplicate()
		bags[playerIndex].shuffle()
	
	return bags[playerIndex].pop_back()

	# return randi_range(0, 5)

func rollDice(playerIndex: int) -> int:
	roll = generateNewRoll(playerIndex)
	diceSprite.spinDice(roll)
	print("Rolled a " + str(roll + 1))
	return roll + 1

func getReadyToRoll():
	diceSprite.goToMiddle()

func debugPlayerBags() -> String:
	var result = ""
	for i in range(bags.size()):
		result += "Player " + str(i) + ": " + str(bags[i].duplicate().map(func(x): return x + 1))
		if !i:
			result += "\n"
	
	return result

func resetBags():
	bags = [[],[]]

# func _input(event: InputEvent):
# 	if event.is_action_pressed("centerCamera"):
# 		position = get_viewport_rect().size / 2
# 		rollDice()
