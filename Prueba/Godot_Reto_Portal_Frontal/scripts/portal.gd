extends Area2D

@export var es_izquierdo: bool = true

const MEDIO_ANCHO: float = 16.0
const RADIO_PERSONAJE: float = 23.0
const MITAD_ENTRADA: float = 27.0
const MARGEN_FISICA: float = 5.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body != get_parent().get_node("Personaje"):
		return

	var personaje := body as CharacterBody2D
	var anterior: Vector2 = personaje.get("posicion_anterior")
	var actual: Vector2 = personaje.global_position
	var centro: Vector2 = global_position

	if absf(actual.y - centro.y) > MITAD_ENTRADA:
		return

	if absf(personaje.velocity.x) <= absf(personaje.velocity.y):
		return

	if es_izquierdo:
		var cara: float = centro.x + MEDIO_ANCHO + RADIO_PERSONAJE
		if personaje.velocity.x >= 0.0 or anterior.x < cara - MARGEN_FISICA:
			return
	else:
		var cara: float = centro.x - MEDIO_ANCHO - RADIO_PERSONAJE
		if personaje.velocity.x <= 0.0 or anterior.x > cara + MARGEN_FISICA:
			return

	call_deferred("_teletransportar", personaje)


func _teletransportar(personaje: CharacterBody2D) -> void:
	if not is_instance_valid(personaje):
		return

	var ancho: float = get_viewport_rect().size.x
	var destino_x: float = ancho - 130.0 if es_izquierdo else 130.0
	personaje.global_position = Vector2(destino_x, personaje.global_position.y)
	personaje.velocity = Vector2.ZERO
	personaje.set("posicion_anterior", personaje.global_position)


func _draw() -> void:
	draw_circle(Vector2.ZERO, 46.0, Color("#172747"))
	draw_arc(Vector2.ZERO, 38.0, 0.0, TAU, 60, Color("#67b7ff"), 5.0)
	draw_arc(Vector2.ZERO, 27.0, 0.0, TAU, 60, Color("#b7e7ff"), 2.0)
	var lado: float = 1.0 if es_izquierdo else -1.0
	draw_line(Vector2(20.0 * lado, -20.0), Vector2(20.0 * lado, 20.0), Color("#ffffff"), 3.0)
