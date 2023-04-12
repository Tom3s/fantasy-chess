@tool
extends Node

class_name MoveComponent

const MAX_MOVES := 6
const MOVEMENT_TIME := 0.3
const ATTACK_COST: int = 4
var EMPTY_ARRAY: Array[Vector2i] = []

@onready
var localPosition: Vector2i :
	set(newPosition): 
		localPosition = onPositionChanged(newPosition)
	get: 
		return localPosition

var movementClass: Script

var classAvailableMoves: Callable
var classAvailableAttacks: Callable
var classCalculateCost: Callable

var parentPiece: Piece
# var parentTargetPosition: Vector2

var startingPosition: Vector2i

func _ready():
	parentPiece = Piece.new()

func init(movementClassPath: String, initialPosition: Vector2i, parent: Piece):
	startingPosition = initialPosition
	parentPiece = parent
	
	localPosition = initialPosition
	parentPiece.position = localPosition * GlobalVariables.GRID_SIZE

	movementClass = load(movementClassPath)

func getAvailableMoves(maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	return movementClass.getAvailableMoves(localPosition, maxCost, occupiedTiles)

func getAvailableAttacks(maxCost: int, enemyOccupiedTiles: Array[Vector2i], allOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	return movementClass.getAvailableAttacks(localPosition, maxCost, enemyOccupiedTiles, allOccupiedTiles) if maxCost >= ATTACK_COST else EMPTY_ARRAY

func targetTileAfterAttack(targetPosition: Vector2i, occupiedTiles: Array[Vector2i]) -> Vector2i:
	var afterAttackTile: Vector2i = movementClass.targetTileAfterAttack(localPosition, targetPosition, occupiedTiles)
	return afterAttackTile

func calculateCost(targetPosition: Vector2i) -> int:
	return movementClass.calculateCost(localPosition, targetPosition)

func moveTo(targetPosition: Vector2i) -> int:
	localPosition = targetPosition
	return calculateCost(targetPosition)

func setPosition(newPosition: Vector2i):
	localPosition = onPositionChanged(newPosition)
	
func onPositionChanged(newPosition: Vector2i) -> Vector2i:
	create_tween().tween_property(parentPiece, "position", Vector2(newPosition) * GlobalVariables.GRID_SIZE, MOVEMENT_TIME).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	return newPosition
