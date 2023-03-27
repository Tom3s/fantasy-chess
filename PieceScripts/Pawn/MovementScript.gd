extends Node

# class_name PawnMovement
# var TargetLocation := load("res://TargetLocation.gd") as TargetLocation

static func getAvailableMoves(position: Vector2i, maxCost: int) -> Array[Vector2i]:
    print("getAvailableMoves called from movescript", position)
    var availableMoves: Array[Vector2i] = []
    for i in range(position.y - maxCost, position.y + maxCost + 1):
        if i == position.y:
            continue
        
        var targetPosition := Vector2i(position.x, i)

        availableMoves.append(targetPosition)
    
    
    print("Available moves from movescript: ", availableMoves)

    return availableMoves

static func getAvailableAttacks(position: Vector2i) -> Array[Vector2i]:
    var availableAttacks: Array[Vector2i] = []
    for x in [-1, 1]:
        for y in [-1, 1]:
            var targetPosition := Vector2i(position.x + x, position.y + y)
            availableAttacks.append(targetPosition)
    
    return availableAttacks


static func calculateCost(position: Vector2i, targetPosition: Vector2i) -> int:
    return abs(position.y - targetPosition.y)