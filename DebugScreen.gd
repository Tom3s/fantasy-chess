extends RichTextLabel

class_name DebugScreen

var debugRows: Array[Callable]

var enabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	addFunctionToDisplay(Callable(%InputHandler, "debugLocalMousePosition"))
	addFunctionToDisplay(Callable(GlobalVariables, "debugBoardDimensions"))
	addFunctionToDisplay(Callable($"../../Board", "debugReachableTiles"))
	addFunctionToDisplay(Callable(%GameController, "debugCurrentPlayer"))
	addFunctionToDisplay(Callable(%Camera2D, "debugCameraPosition"))
	addFunctionToDisplay(Callable(%Camera2D, "debugCameraZoom"))
	addFunctionToDisplay(Callable(%Dice, "debugPlayerBags"))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not enabled:
		text = ''
		return
	var debugText: String = 'FPS: ' + str(Engine.get_frames_per_second()) + '\n'
	for function in debugRows:
		debugText += function.call() + '\n'
	text = debugText

func addFunctionToDisplay(textFunction: Callable):
	debugRows.append(textFunction)

func toggleDebugScreen():
	enabled = !enabled
