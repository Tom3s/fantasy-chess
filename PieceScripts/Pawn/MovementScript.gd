extends Node

# class_name PawnMovement
# var TargetLocation := load("res://TargetLocation.gd") as TargetLocation

static func getAvailableMoves(position: Vector2i, maxCost: int) -> Array[TargetLocation]:
    var availableMoves: Array[TargetLocation] = []
    for i in range(-maxCost, maxCost + 1):
        if i == position.y:
            continue
        
        var targetPosition := Vector2i(position.x, i)
        var targetLocation := TargetLocation.init(targetPosition, calculateCost(position, targetPosition))

        availableMoves.append(targetLocation)
    
    return availableMoves

static func getAvailableAttacks(position: Vector2i) -> Array[TargetLocation]:
    var availableAttacks: Array[TargetLocation] = []
    for x in [-1, 1]:
        for y in [-1, 1]:
            var targetPosition := TargetLocation.init(Vector2i(position.x + x, position.y + y), 1, true)
            availableAttacks.append(targetPosition)
    
    return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
    return abs(position.y - targetPosition.y)