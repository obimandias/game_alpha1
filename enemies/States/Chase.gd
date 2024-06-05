extends State

var direction: Vector2 = Vector2.ZERO
var target: Node2D
var area_2d: Area2D
var sprite: AnimatedSprite2D

func _ready():
    var state_machine = get_parent()
    area_2d = state_machine.get_parent()
    sprite = area_2d.get_node("sprite")

func enter(shared_state: SharedState):
    target = shared_state.target
    area_2d.body_exited.connect(on_body_exited)
    sprite.speed_scale = 2

func exit():
    area_2d.body_exited.disconnect(on_body_exited)
    sprite.speed_scale = 1

func physics_process(_delta):
    direction = target.position - area_2d.position
    direction = direction.normalized() * 2
    print("Chasing ", direction)
    area_2d.translate(direction)

func on_body_exited(body: Node2D):
    print("Body exited")
    transition.emit(self, "Patrol", null)
