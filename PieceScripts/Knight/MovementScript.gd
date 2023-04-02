extends Node

static func getAvailableMoves(position: Vector2i, maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableMoves: Array[Vector2i] = [position]
	var hops = [
		Vector2i(2, 1),
		Vector2i(2, -1),
		Vector2i(-2, 1),
		Vector2i(-2, -1),
		Vector2i(1, 2),
		Vector2i(1, -2),
		Vector2i(-1, 2),
		Vector2i(-1, -2)
	]
	for hop in hops:
		var targetPosition = position + hop
		if targetPosition in occupiedTiles or targetPosition in availableMoves:
			continue
		availableMoves.append(targetPosition)

	return availableMoves

static func getAvailableAttacks(position: Vector2i, maxCost: int, enemyOccupiedTiles: Array[Vector2i], allOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
	var availableAttacks: Array[Vector2i] = []
	var hops = [
		Vector2i(2, 1),
		Vector2i(2, -1),
		Vector2i(-2, 1),
		Vector2i(-2, -1),
		Vector2i(1, 2),
		Vector2i(1, -2),
		Vector2i(-1, 2),
		Vector2i(-1, -2)
	]
	# for i in maxCost:
	# 	for tempHop in availableMoves:
	for hop in hops:
		var targetPosition = position + hop
		if targetPosition in enemyOccupiedTiles:
			availableAttacks.append(targetPosition)

	return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
	return 1

static func targetTileAfterAttack(localPosition, targetPosition) -> Vector2i:
	var normalizedDirection = (localPosition - targetPosition).sign()
	return targetPosition + normalizedDirection
