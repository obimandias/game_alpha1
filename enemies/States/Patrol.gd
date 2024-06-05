extends State

var direction: Vector2 = Vector2.ZERO
@export var timer: Timer
@export var bug: Area2D

func enter(_shared_state: SharedState):
    on_timer_ready()
    timer.timeout.connect(on_timer_ready)
    bug.body_entered.connect(on_body_entered)

func exit():
    timer.timeout.disconnect(on_timer_ready)
    bug.body_entered.disconnect(on_body_entered)

func physics_process(_delta):

    print("Patrolling", direction)
    bug.translate(direction)

func on_timer_ready():
    direction = Vector2(randi_range(-1,1), randi_range(-1,1))
    var random_time = randi_range(1,3)
    timer.start(random_time)

func on_body_entered(body: Node2D):
    if body.is_in_group("player"):
        transition.emit(self, "Chase", body)
