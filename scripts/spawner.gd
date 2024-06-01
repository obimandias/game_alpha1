extends Node2D

@export var spawn: PackedScene
@onready var timer = $Timer

var bbox = Vector2.ZERO

func _ready():
	var viewport = timer.get_viewport()
	bbox = viewport.get_visible_rect().size * 0.8
	timer.start(3)
	timer.timeout.connect(timer_event)

func timer_event():
	var position = Vector2(randi_range(0, bbox.x), randi_range(0, bbox.y))
	var new_spawn = spawn.instantiate()
	new_spawn.position = position
	add_child(new_spawn)
	timer.start(3)
