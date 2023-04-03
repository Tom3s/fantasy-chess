extends Node2D

class_name Piece

const HealthComponent := preload("res://HealthComponent.tscn")
const MoveComponent := preload("res://MoveComponent.tscn")
const PieceGraphic := preload("res://PieceGraphic.tscn")

@export
var pieceType: String

var dataPath: String
var movePath: String
var texturePath: String

var health: HealthComponent
var move: MoveComponent
var graphic: PieceGraphic
var lightOccluder: LightOccluder2D
var attackStrength: int

var isSelected: bool = false

func init(type: String, initialPosition: Vector2i, pieceColor: Color):
	pieceType = type

	texturePath = "res://PieceScripts/" + pieceType + "/icon.png"
	graphic = PieceGraphic.instantiate()
	add_child(graphic)
	graphic.init(texturePath, pieceColor)

	dataPath = "res://PieceScripts/" + pieceType + "/data.json"

	var file := FileAccess.open(dataPath, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var maxHealth = data["maxHealth"]
	attackStrength = data["attackStrength"]

	health = HealthComponent.instantiate()
	add_child(health)
	health.init(maxHealth, self)
	

	# moveClass = 
	movePath = "res://PieceScripts/" + pieceType + "/MovementScript.gd"
	move = MoveComponent.instantiate()
	add_child(move)
	move.init(movePath, initialPosition, self)


	var occluderPath = "res://PieceScripts/" + pieceType + "/occluder.tres"
	lightOccluder = LightOccluder2D.new()
	lightOccluder.occluder = ResourceLoader.load(occluderPath)
	add_child(lightOccluder)

	graphic.attackAnimationDone.connect(onAttackAnimationDone)


func onSelected():
	isSelected = true
	graphic.setToSelected()
	
func onUnselected():
	isSelected = false
	graphic.setToUnselected()
	
func onMoved():
	isSelected = false
	graphic.setToUnselected()

func onAttack(attackedPosition: Vector2i, occupiedTiles: Array[Vector2i]):
	var afterAttackTile = move.targetTileAfterAttack(attackedPosition, occupiedTiles)
	graphic.playAttack(self, attackedPosition, afterAttackTile)

func onDamageTaken():
	graphic.playDamageTaken()

func onAttackAnimationDone(afterAttackTile: Vector2i):
	move.moveTo(afterAttackTile)
	onUnselected()

func onKill(attackedPosition: Vector2i):
	move.moveTo(attackedPosition)
	onUnselected()
