extends Polygon2D

func _ready():
    var vertices := [
        Vector2(70, 240),
        Vector2(70, 220),
        Vector2(20, 140),
        Vector2(45, 124),
        Vector2(45, 120),
        Vector2(20, 120),
        Vector2(30, 100),
        Vector2(20, 70),
        Vector2(0, 60)
        # Vector2(-20, 70),
        # Vector2(-30, 100),
        # Vector2(-20, 120),
        # Vector2(-50, 120),
        # Vector2(-20, 140),
        # Vector2(-70, 220),
        # Vector2(-70, 240)
    ] 
    var aux = []
    for vertex in vertices:
        aux.append(vertex)
    
    aux.reverse()
    aux.remove_at(0)

    for vertex in aux:
        vertices.append(Vector2(-vertex.x, vertex.y))

    for i in vertices.size():
        vertices[i] = vertices[i] + Vector2(128, 0)

    print(vertices)

    polygon = vertices

func _draw():
    for i in polygon.size() - 1:
        draw_line(polygon[i], polygon[i + 1], Color.BLACK, 5, false)
    draw_line(polygon[-1], polygon[0], Color.BLACK, 5, false)