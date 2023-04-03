extends Label

var offsetX = 15
var offsetY = 15

var enemyOccupiedTiles: Array[Vector2i]
var attackerPiece: Piece
# var targetPiece: Piece

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_global_mouse_position() + Vector2(offsetX, offsetY)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position() + Vector2(offsetX, offsetY)

func setText(target: Piece) -> void:
	if target == null || attackerPiece == null:
		text = ""
		return
	
	if target.move.localPosition not in enemyOccupiedTiles:
		text = ""
		return

	var attackStrength = attackerPiece.attackStrength
	var targetPieceHealth = target.health.currentHealth

	var newText = "Attack: " + str(attackStrength)
	if attackStrength >= targetPieceHealth:
		newText += " (Kills)"
	else:
		newText += " (HP Left: " + str(targetPieceHealth - attackStrength) + ")"
	text = newText

func setAttacks(attacker: Piece, tiles: Array[Vector2i]) -> void:
	enemyOccupiedTiles = tiles
	attackerPiece = attacker
	# setText(attackerPiece, targetPiece)

func clearText() -> void:
	text = ""