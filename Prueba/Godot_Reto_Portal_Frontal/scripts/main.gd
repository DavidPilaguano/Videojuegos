extends Node2D

var score: int = 0
var recogiendo: bool = false

@onready var label: Label = $Label
@onready var estrella: Area2D = $Estrella
@onready var personaje: CharacterBody2D = $Personaje


func _ready() -> void:
	randomize()
	estrella.body_entered.connect(_on_estrella_body_entered)
	label.text = "Score: 0"


func _on_estrella_body_entered(body: Node2D) -> void:
	if body != personaje or recogiendo or score >= 10:
		return

	recogiendo = true
	call_deferred("_recoger_estrella")


func _recoger_estrella() -> void:
	score += 1
	label.text = "Score: " + str(score)

	if score == 5:
		personaje.velocidad = 350.0
		label.text = "Score: 5  |  ¡Más rápido!"

	if score >= 10:
		label.text = "¡GANASTE! Score: 10  |  Pulsa R para reiniciar"
		estrella.hide()
		estrella.set_deferred("monitoring", false)
	else:
		_nueva_posicion_estrella()

	recogiendo = false


func _nueva_posicion_estrella() -> void:
	var tamano: Vector2 = get_viewport_rect().size
	var nueva_posicion := Vector2(tamano.x / 2.0, tamano.y / 2.0)

	
	for _intento in range(40):
		nueva_posicion = Vector2(
			randf_range(70.0, tamano.x - 70.0),
			randf_range(110.0, tamano.y - 60.0)
		)
		if nueva_posicion.distance_to(personaje.position) >= 110.0:
			break

	estrella.position = nueva_posicion


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_R:
			get_tree().reload_current_scene()


func _draw() -> void:
	var tamano: Vector2 = get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, tamano), Color("#101a30"))

	for x in range(90, int(tamano.x), 90):
		for y in range(110, int(tamano.y), 90):
			draw_circle(Vector2(x, y), 2.0, Color("#314868"))
#David Pilaguano
