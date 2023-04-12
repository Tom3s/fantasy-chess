extends Node2D

class_name AbilityComponent

var parentPiece: Piece
var abilityScript: Script

func init(abilityScriptPath: String, parent: Piece):
	parentPiece = parent

	abilityScript = load(abilityScriptPath)

func useAbility():
	abilityScript.use(parentPiece)

func canUseAbility():
	return abilityScript.canUse(parentPiece)
