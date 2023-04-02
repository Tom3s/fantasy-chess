extends Node

static func getAvailableMoves(position: Vector2i, maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableMoves: Array[Vector2i] = []
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x + i, position.y + i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x - i, position.y + i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x - i, position.y - i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x + i, position.y - i)
		if targetPosition in occupiedTiles:
			break
		availableMoves.append(targetPosition)
	
	

	return availableMoves

static func getAvailableAttacks(position: Vector2i, maxCost: int, enemyOccupiedTiles: Array[Vector2i], allOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableAttacks: Array[Vector2i] = []
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x + i, position.y + i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
		if targetPosition in allOccupiedTiles:
			break
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x - i, position.y + i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
		if targetPosition in allOccupiedTiles:
			break   
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x - i, position.y - i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
		if targetPosition in allOccupiedTiles:
			break   
	
	for i in range(1, maxCost + 1):
		var targetPosition := Vector2i(position.x + i, position.y - i)
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)
			break
		if targetPosition in allOccupiedTiles:
			break   
	return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
	return abs(position.x - targetPosition.x)

static func targetTileAfterAttack(localPosition, targetPosition) -> Vector2i:
	var normalizedDirection = (localPosition - targetPosition).sign()
	return targetPosition + normalizedDirection
