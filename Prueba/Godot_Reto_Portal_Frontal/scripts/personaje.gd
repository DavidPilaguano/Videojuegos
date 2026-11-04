extends CharacterBody2D

@export var velocidad: float = 250.0


var posicion_anterior: Vector2


func _ready() -> void:
	posicion_anterior = global_position


func _physics_process(_delta: float) -> void:
	posicion_anterior = global_position

	var direccion := Input.get_vector(
		"ui_left", "ui_right", "ui_up", "ui_down"
	)

	if Input.is_key_pressed(KEY_A):
		direccion.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		direccion.x += 1.0
	if Input.is_key_pressed(KEY_W):
		direccion.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		direccion.y += 1.0

	velocity = direccion.normalized() * velocidad
	move_and_slide()

	var tamano: Vector2 = get_viewport_rect().size
	position.x = clampf(position.x, 23.0, tamano.x - 23.0)
	position.y = clampf(position.y, 105.0, tamano.y - 35.0)


func _draw() -> void:
	draw_circle(Vector2.ZERO, 24.0, Color("#6ce5ca"))
	draw_arc(Vector2.ZERO, 23.0, 0.0, TAU, 48, Color("#ddfff7"), 2.5)
