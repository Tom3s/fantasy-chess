extends Node

static func getAvailableMoves(position: Vector2i, maxCost: int, occupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
    var availableMoves: Array[Vector2i] = []
    for i in range(position.y - 1, position.y - maxCost - 1, -1):
        var targetPosition := Vector2i(position.x, i)
        if targetPosition in occupiedTiles:
            break
        availableMoves.append(targetPosition)
    
    for i in range(position.y + 1, position.y + maxCost + 1):
        var targetPosition := Vector2i(position.x, i)
        if targetPosition in occupiedTiles:
            break
        availableMoves.append(targetPosition)
    
    

    return availableMoves

static func getAvailableAttacks(position: Vector2i, maxCost: int, enemyOccupiedTiles: Array[Vector2i], allOccupiedTiles: Array[Vector2i]) -> Array[Vector2i]:
    var availableAttacks: Array[Vector2i] = []
    for x in [-1, 1]:
        for y in [-1, 1]:
            var targetPosition := Vector2i(position.x + x, position.y + y)
            if targetPosition in enemyOccupiedTiles:
                availableAttacks.append(targetPosition)
    
    return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
    return abs(position.y - targetPosition.y)

static func targetTileAfterAttack(localPosition: Vector2i, targetPosition: Vector2i, occupiedTiles: Array[Vector2i]) -> Vector2i:
    return localPosition