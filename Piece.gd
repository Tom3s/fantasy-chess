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
var attackStrength: int

var isSelected: bool = false

func init(type: String, initialPosition: Vector2i, pieceColor: Color):
	pieceType = type

	texturePath = "res://PieceScripts/" + pieceType + "/icon.png"
	graphic = PieceGraphic.instantiate()
	add_child(graphic)
	graphic.init(texturePath, pieceColor)

	dataPath = "res://PieceScripts/" + pieceType + "/data.json"
	print(dataPath)

	var file := FileAccess.open(dataPath, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var maxHealth = data["maxHealth"]
	attackStrength = data["attackStrength"]

	health = HealthComponent.instantiate()
	add_child(health)
	health.init(maxHealth)
	

	# moveClass = 
	movePath = "res://PieceScripts/" + pieceType + "/MovementScript.gd"
	move = MoveComponent.instantiate()
	add_child(move)
	move.init(movePath, initialPosition, self)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	# init()

	# print(get_node("Graphic").skeleton)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func onSelected():
	isSelected = true
	graphic.setToSelected()
	pass
	
func onUnselected():
	isSelected = false
	graphic.setToUnselected()
	pass
	
func onMoved():
	isSelected = false
	graphic.setToUnselected()
	pass

func onAttack(attackedPosition: Vector2i):
	move.moveTo(move.targetTileAfterAttack(attackedPosition))
	onUnselected()
	pass

func onKill(attackedPosition: Vector2i):
	move.moveTo(attackedPosition)
	onUnselected()
	pass
