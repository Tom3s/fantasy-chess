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

static func targetTileAfterAttack(localPosition: Vector2i, targetPosition: Vector2i, occupiedTiles: Array[Vector2i]) -> Vector2i:
	# This is kind of a mess, but mathematically this is correct
	# Check res://notes/knight_attack.png for a visual representation and more clarity
	# Check res://notes/knight_attack.md for a more detailed explanation
	var normalizedDirection = (localPosition - targetPosition).sign()
	var potentialTargetPosition = targetPosition + normalizedDirection # diagonal to target
	if potentialTargetPosition not in occupiedTiles:
		return potentialTargetPosition
	
	potentialTargetPosition = targetPosition + Vector2i(normalizedDirection.x, 0) # horizontal to target
	if potentialTargetPosition not in occupiedTiles:
		return potentialTargetPosition
	
	potentialTargetPosition = targetPosition + Vector2i(0, normalizedDirection.y) # vertical to target
	if potentialTargetPosition not in occupiedTiles:
		return potentialTargetPosition
	
	var relativePosition = targetPosition - localPosition
	var relativeLastTile = (relativePosition + normalizedDirection) * -2
	potentialTargetPosition = targetPosition + relativeLastTile # next to local
	if potentialTargetPosition not in occupiedTiles:
		return potentialTargetPosition

	return localPosition # stay in place if no other option
