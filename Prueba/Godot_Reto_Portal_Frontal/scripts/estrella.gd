extends Area2D

func _process(delta: float) -> void:
	rotation += 1.5 * delta


func _draw() -> void:
	var vertices := PackedVector2Array()

	for i in range(10):
		var angulo := -PI / 2.0 + i * PI / 5.0
		var radio := 23.0 if i % 2 == 0 else 10.0
		vertices.append(Vector2(cos(angulo), sin(angulo)) * radio)

	draw_colored_polygon(vertices, Color("#ffd447"))
	draw_circle(Vector2.ZERO, 4.0, Color("#fff5ae"))
