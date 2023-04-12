extends Node2D

class_name HealthComponent

const HealthDisplay := preload("res://HealthDisplay.tscn")

var currentHealth: float

var maxHealth: float = 69

var healthDisplay = null

var parentPiece: Piece = null

func init(initialMaxHealth, parent: Piece) -> void:
	maxHealth = initialMaxHealth
	currentHealth = maxHealth
	parentPiece = parent
	
	healthDisplay = HealthDisplay.instantiate()
	healthDisplay.init(Callable(self, "getHealth"), Callable(self, "getMaxHealth"))
	add_child(healthDisplay)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# if healthDisplay == null:
	# 	init(null, null)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.


func takeDamage(amount: float) -> float:
	currentHealth -= amount
	healthDisplay.update()
	parentPiece.onDamageTaken()
	if currentHealth <= 0:
		die()
		return amount + currentHealth
	return amount

func die() -> void:
	queue_free()

func heal(amount: float) -> float:
	currentHealth += amount
	if currentHealth > maxHealth:
		var overHeal = currentHealth - maxHealth
		currentHealth = maxHealth
		return amount - overHeal
	return amount

func getHealth() -> float:
	return currentHealth

func setHealth(amount: float) -> void:
	currentHealth = amount
	healthDisplay.update()

func getMaxHealth() -> float:
	return maxHealth

func isHealthFull() -> bool:
	return currentHealth == maxHealth

func isDead() -> bool:
	return is_zero_approx(currentHealth) || currentHealth < 0



	
