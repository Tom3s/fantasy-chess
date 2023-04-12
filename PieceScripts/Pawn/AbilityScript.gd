extends Node

class_name PawnAbility

static func use(parentPiece: Piece) -> void:
	var promotionSelector = PawnPromotionSelector.new(parentPiece)

	parentPiece.get_parent().add_child(promotionSelector)

	promotionSelector.promotionPieceSelected.connect(
		func(newPiece: String, parentPiece: Piece):
			var oldHP := parentPiece.health.getHealth()
			var oldAttack := parentPiece.attackStrength
			var oldPos := parentPiece.move.localPosition
			var oldColor = parentPiece.initialColor

			parentPiece.init(newPiece, oldPos, oldColor)

			parentPiece.health.setHealth(oldHP)
			parentPiece.attackStrength = oldAttack + 2

			parentPiece.hasAbility = false

			parentPiece.abilityUsed.emit()
	)


func promotePawn(newPiece: String, parentPiece: Piece) -> void:
	var oldHP := parentPiece.health.getHealth()
	var oldAttack := parentPiece.attackStrength
	var oldPos := parentPiece.move.localPosition
	var oldColor = parentPiece.initialColor

	parentPiece.init(newPiece, oldPos, oldColor)

	parentPiece.health.setHealth(oldHP)
	parentPiece.attackStrength = oldAttack + 2

	parentPiece.hasAbility = false
