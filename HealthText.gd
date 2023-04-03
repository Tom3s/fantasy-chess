extends Label

class_name HealthText

func setText(currentHealth: float, maxHealth: float):
	var newText = "HP: " + str(currentHealth) + "/" + str(maxHealth)
	text = newText