extends Node

# class_name PawnMovement
# var TargetLocation := load("res://TargetLocation.gd") as TargetLocation

static func getAvailableMoves(position: Vector2i, maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableMoves: Array[Vector2i] = []
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x + i, position.y + i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x - i, position.y + i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x - i, position.y - i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x + i, position.y - i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	

	return availableMoves

static func getAvailableAttacks(position: Vector2i, enemyOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableAttacks: Array[Vector2i] = []
	var maxCost = 6
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x + i, position.y + i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x - i, position.y + i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x - i, position.y - i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
	
	for i in range(1, maxCost):
		var targetPosition := Vector2i(position.x + i, position.y - i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
	return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
	return abs(position.x - targetPosition.x)

static func targetTileAfterAttack(localPosition, targetPosition) -> Vector2i:
	var directionX = localPosition.x - targetPosition.x
	var directionY = localPosition.y - targetPosition.y
	return Vector2i(targetPosition.x + (directionX / abs(directionX)), targetPosition.y + (directionY / abs(directionY)))
