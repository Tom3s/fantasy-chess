extends Node2D

const HealthComponent := preload("res://HealthComponent.tscn")
const MoveComponent := preload("res://MoveComponent.tscn")

@export
var pieceType: String

var dataPath: String
var movePath: String

var health: HealthComponent
var move: MoveComponent

func init(type: String = "Pawn"):
	pieceType = type
	dataPath = "res://PieceScripts/" + pieceType + "/data.json"
	print(dataPath)
	health = HealthComponent.instantiate()
	health.init(dataPath)
	add_child(health)

	# moveClass = 
	movePath = "res://PieceScripts/" + pieceType + "/MovementScript.gd"
	move = MoveComponent.instantiate()
	move.init(movePath, Vector2i(0, 0))
	add_child(move)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
