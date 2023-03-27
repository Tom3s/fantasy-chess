@tool
extends Node

class_name MoveComponent

const MAX_MOVES = 6

# var TargetLocation := load("res://TargetLocation.gd")

var localPosition: Vector2i :
	# set(newPosition): setPosition(newPosition)
	set(newPosition): 
		localPosition = onPositionChanged(newPosition)
	get: 
		return localPosition

var movementClass: Script

var classAvailableMoves: Callable
var classAvailableAttacks: Callable
var classCalculateCost: Callable

var parentPiece: Piece

func init(movementClassPath: String, initialPosition: Vector2i, parent: Piece):
	parentPiece = parent
	
	localPosition = initialPosition

	print("Movement class path: " + movementClassPath)

	movementClass = load(movementClassPath)

func getAvailableMoves(maxCost: int) -> Array[Vector2i]:
	return movementClass.getAvailableMoves(localPosition, maxCost)

func getAvailableAttacks() -> Array[Vector2i]:
	return movementClass.getAvailableAttacks(localPosition)

func calculateCost(targetPosition: Vector2i) -> int:
	return movementClass.calculateCost(localPosition, targetPosition)

func moveTo(targetPosition: Vector2i) -> int:
	# if targetPosition not in getAvailableMoves(MAX_MOVES):
	# 	push_error("Invalid move position")
	# 	return 0
	
	localPosition = targetPosition
	return calculateCost(targetPosition)

func setPosition(newPosition: Vector2i):
	localPosition = onPositionChanged(newPosition)
	
func onPositionChanged(newPosition: Vector2i) -> Vector2i:
	parentPiece.position = newPosition * GlobalVariables.GRID_SIZE
	return newPosition
