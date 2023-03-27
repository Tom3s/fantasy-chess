extends RichTextLabel

class_name DebugScreen

var debugRows: Array[Callable]

# Called when the node enters the scene tree for the first time.
func _ready():
	addFunctionToDisplay(Callable(%InputHandler, "debugLocalMousePosition"))
	addFunctionToDisplay(Callable(GlobalVariables, "debugBoardDimensions"))
	addFunctionToDisplay(Callable($"../../Board", "debugReachableTiles"))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var debugText: String = 'FPS: ' + str(Engine.get_frames_per_second()) + '\n'
	for function in debugRows:
		debugText += function.call() + '\n'
	text = debugText

func addFunctionToDisplay(textFunction: Callable):
	debugRows.append(textFunction)
