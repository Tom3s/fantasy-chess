extends Node

class_name MoveComponent

const MAX_MOVES = 6

var TargetLocation := load("res://TargetLocation.gd")

var position: Vector2i

var movementClass: Script

var classAvailableMoves: Callable
var classAvailableAttacks: Callable
var classCalculateCost: Callable

func init(movementClassPath: String, initialPosition: Vector2i):
	self.position = initialPosition

	print("Movement class path: " + movementClassPath)

	movementClass = load(movementClassPath)

	# var temp = movementClass.getAvailableMoves(position, MAX_MOVES)

	# print(temp)

	# classAvailableMoves = Callable(movementClass, "getAvailableMoves")
	# print(classAvailableMoves)
	# classAvailableAttacks = Callable(movementClass, "getAvailableAttacks")
	# classCalculateCost = Callable(movementClass, "calculateCost")

func getAvailableMoves(maxCost: int) -> Array[TargetLocation]:
	return movementClass.getAvailableMoves(position, maxCost)

func getAvailableAttacks() -> Array[TargetLocation]:
	return movementClass.getAvailableAttacks(position)

func calculateCost(targetPosition: Vector2i) -> int:
	return movementClass.calculateCost(position, targetPosition)

func moveTo(targetPosition: Vector2i) -> int:
	if targetPosition not in getAvailableMoves(MAX_MOVES):
		push_error("Invalid move position")
		return 0
	
	self.position = targetPosition
	return calculateCost(targetPosition)
