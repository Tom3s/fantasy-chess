extends Node2D

class_name Piece

const HealthComponent := preload("res://HealthComponent.tscn")
const MoveComponent := preload("res://MoveComponent.tscn")
const PieceGraphic := preload("res://PieceGraphic.tscn")

@export
var pieceType: String

var dataPath: String
var movePath: String
var graphicPath: String

var health: HealthComponent
var move: MoveComponent
var graphic: PieceGraphic

var isSelected: bool = false

func init(type: String, initialPosition: Vector2i):
	pieceType = type

	graphicPath = "res://PieceScripts/" + pieceType + "/Graphic.tscn"
	graphic = PieceGraphic.instantiate()
	graphic.init(graphicPath)
	add_child(graphic)

	dataPath = "res://PieceScripts/" + pieceType + "/data.json"
	print(dataPath)
	health = HealthComponent.instantiate()
	health.init(dataPath)
	add_child(health)
	

	health.addHealthBarOffset(graphic.healtBarPosition)
	# moveClass = 
	movePath = "res://PieceScripts/" + pieceType + "/MovementScript.gd"
	move = MoveComponent.instantiate()
	move.init(movePath, initialPosition, self)
	add_child(move)
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
