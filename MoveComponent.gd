@tool
extends Node

class_name MoveComponent

const MAX_MOVES := 6
const MOVEMENT_SPEED := 15.0

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
var parentTargetPosition: Vector2

func init(movementClassPath: String, initialPosition: Vector2i, parent: Piece):
	parentPiece = parent
	
	localPosition = initialPosition
	parentPiece.position = localPosition * GlobalVariables.GRID_SIZE

	print("Movement class path: " + movementClassPath)

	movementClass = load(movementClassPath)

func _process(delta):
	parentPiece.position = lerp(parentPiece.position, parentTargetPosition, MOVEMENT_SPEED * delta)


func getAvailableMoves(maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	return movementClass.getAvailableMoves(localPosition, maxCost, occupiedTiles)

func getAvailableAttacks(enemyOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	return movementClass.getAvailableAttacks(localPosition, enemyOccupiedTiles)

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
	parentTargetPosition = newPosition * GlobalVariables.GRID_SIZE
	return newPosition
