@tool
extends Node2D

# class_name GlobalVariables

@export
var GRID_SIZE: int = 256

var BOARD_HEIGHT: int = 10
var BOARD_WIDTH: int = 10

func setBoardDimensions(width, height) -> void:
	BOARD_WIDTH = width
	BOARD_HEIGHT = height


func debugBoardDimensions() -> String:
	return "Board Dimensions: " + str(BOARD_WIDTH) + "x" + str(BOARD_HEIGHT)

func isTilePositionValid(tilePos: Vector2i) -> bool:
	return tilePos.x >= 0 and tilePos.y >= 0 and tilePos.x < GlobalVariables.BOARD_WIDTH and tilePos.y < GlobalVariables.BOARD_HEIGHT