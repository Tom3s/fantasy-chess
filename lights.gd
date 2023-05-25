extends Node2D

var lights: Array[PointLight2D] = []
@export
var LIGHT_COLOR: Color = Color("ff9566"):
	set(newColor):
		LIGHT_COLOR = onLightColorChange(newColor)
	get:
		return LIGHT_COLOR
@export
var LIGHT_ENERGY: float = 0.67:
	set(newEnergy):
		LIGHT_ENERGY = onLightEnergyChange(newEnergy)
	get:
		return LIGHT_ENERGY

@export
var LIGHT_TEXTURE: Texture2D = preload("res://Sprites/light.png"):
	set(newTexture):
		LIGHT_TEXTURE = onLightTextureChange(newTexture)
	get:
		return LIGHT_TEXTURE

@export
var LIGHT_SCALE: float = 5:
	set(newScale):
		LIGHT_SCALE = onLightScaleChange(newScale)
	get:
		return LIGHT_SCALE

# Called when the node enters the scene tree for the first time.
func _ready():
	var offsetFromTop = 1 if GlobalVariables.BOARD_HEIGHT < 6 else 2
	var offsetFromSide = 1 if GlobalVariables.BOARD_WIDTH < 6 else 2

	for i in 4:
		var light = PointLight2D.new()
		light.texture = LIGHT_TEXTURE
		light.color = LIGHT_COLOR
		light.energy = LIGHT_ENERGY
		light.scale = Vector2(LIGHT_SCALE, LIGHT_SCALE)
		light.shadow_enabled = true

		var posX: int
		var posY: int

		match i:
			0:
				posX = offsetFromSide * GlobalVariables.GRID_SIZE
				posY = offsetFromTop * GlobalVariables.GRID_SIZE
			1:
				posX = (GlobalVariables.BOARD_WIDTH - offsetFromSide) * GlobalVariables.GRID_SIZE
				posY = offsetFromTop * GlobalVariables.GRID_SIZE
			2:
				posX = offsetFromSide * GlobalVariables.GRID_SIZE
				posY = (GlobalVariables.BOARD_HEIGHT - offsetFromTop) * GlobalVariables.GRID_SIZE
			3:
				posX = (GlobalVariables.BOARD_WIDTH - offsetFromSide) * GlobalVariables.GRID_SIZE
				posY = (GlobalVariables.BOARD_HEIGHT - offsetFromTop) * GlobalVariables.GRID_SIZE

		light.position = Vector2(posX, posY)
		add_child(light)
		lights.append(light)

func onLightColorChange(newColor: Color) -> Color:
	for light in lights:
		light.color = newColor
	return newColor

func onLightEnergyChange(newEnergy: float) -> float:
	for light in lights:
		light.energy = newEnergy
	return newEnergy

func onLightTextureChange(newTexture: Resource) -> Resource:
	for light in lights:
		light.texture = newTexture
	return newTexture

func onLightScaleChange(newScale: float) -> float:
	for light in lights:
		light.scale = Vector2(newScale, newScale)
	return newScale

