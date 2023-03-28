extends Node2D

class_name HealthComponent

const HealthDisplay := preload("res://HealthDisplay.tscn")

var currentHealth: float		
var maxHealth: float = 69

var healthDisplay = null

func init(initialMaxHealth = 1) -> void:

	print('Health 1st line')
	
	maxHealth = initialMaxHealth
	currentHealth = maxHealth
	
	healthDisplay = HealthDisplay.instantiate()
	healthDisplay.init(Callable(self, "getHealth"))
	add_child(healthDisplay)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if healthDisplay == null:
		init()
	print('Health')
	print(maxHealth)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func takeDamage(amount: float) -> float:
	currentHealth -= amount
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

func isHealthFull() -> bool:
	return currentHealth == maxHealth

func isDead() -> bool:
	return is_zero_approx(currentHealth) || currentHealth < 0

func addHealthBarOffset(offset: Vector2) -> void:
	healthDisplay.setOffset(offset)


	
