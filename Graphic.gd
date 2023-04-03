extends Sprite2D

class_name Graphic

var pieceColor: Color = Color.WHITE

func init(texturePath: String, initialColor: Color):
    texture = load(texturePath)
    z_index = -1
    setColor(initialColor)

func select():
    material.set_shader_parameter("outline_color", pieceColor)
    material.set_shader_parameter("color", Color.DARK_GRAY)
    pass
    
func unSelect():
    material.set_shader_parameter("outline_color", Color.BLACK)
    material.set_shader_parameter("color", pieceColor)
    pass

func setColor(newColor: Color):
    pieceColor = newColor
    material.set_shader_parameter("color", pieceColor)
    pass

func damageTaken():
    var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
    tween.tween_interval(0.2)
    tween.tween_property(material, "shader_parameter/color", pieceColor, 0.5).from(Color.RED)