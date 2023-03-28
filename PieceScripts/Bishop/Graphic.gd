extends Sprite2D

var pieceColor: Color = Color.WHITE

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