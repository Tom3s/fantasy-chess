extends Resource

class_name TargetLocation

var position: Vector2i
var isAttack: bool = false
var cost: int

static func init(initPosition: Vector2i, initCost: int = 0,initIsAttack: bool = false) -> TargetLocation:
    var targetLocation = TargetLocation.new()
    
    targetLocation.position = initPosition
    targetLocation.isAttack = initIsAttack
    targetLocation.cost = initCost

    return targetLocation

func _to_string():
    var str = "{"
    str += "Position: " + str(position) + ","
    str += "Cost: " + str(cost) + ","
    str += "Is Attack: " + str(isAttack) + "}"

    return str
