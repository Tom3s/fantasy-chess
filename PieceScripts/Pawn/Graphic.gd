extends Sprite2D

func select():
    material.set_shader_parameter("outline_color", Color.DARK_CYAN)
    material.set_shader_parameter("color", Color.LIGHT_GRAY)
    pass
    
func unSelect():
    material.set_shader_parameter("outline_color", Color.BLACK)
    material.set_shader_parameter("color", Color.WHITE)
    pass