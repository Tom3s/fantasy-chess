extends Node

class_name PawnAbility

const PawnPromotionSelector = preload("res://PawnPromotionSelector.tscn")

static func use(parentPiece: Piece) -> void:
	var promotionSelector = PawnPromotionSelector.instantiate()
	
	var UINode = parentPiece.get_parent().get_parent().get_parent().find_child("UI")
	UINode.add_child(promotionSelector)
	promotionSelector.init(parentPiece)

	promotionSelector.promotionPieceSelected.connect(
		func(newPiece: String, parentPiece: Piece):
			var oldHP := parentPiece.health.getHealth()
			var oldPos := parentPiece.move.localPosition
			var oldColor := parentPiece.initialColor

			parentPiece.init(newPiece, oldPos, oldColor)

			parentPiece.health.setHealth(oldHP)
			parentPiece.attackStrength += 2

			parentPiece.hasAbility = false

			parentPiece.abilityUsed.emit()
	)

static func canUse(parentPiece: Piece) -> bool:
	if !parentPiece.hasAbility:
		return false
	
	return (parentPiece.move.localPosition.y == 0 and parentPiece.startedAtTop) or (parentPiece.move.localPosition.y == GlobalVariables.BOARD_HEIGHT - 1 and !parentPiece.startedAtTop)

func promotePawn(newPiece: String, parentPiece: Piece) -> void:
	var oldHP := parentPiece.health.getHealth()
	var oldAttack := parentPiece.attackStrength
	var oldPos := parentPiece.move.localPosition
	var oldColor = parentPiece.initialColor

	parentPiece.init(newPiece, oldPos, oldColor)

	parentPiece.health.setHealth(oldHP)
	parentPiece.attackStrength = oldAttack + 2

	parentPiece.hasAbility = false
