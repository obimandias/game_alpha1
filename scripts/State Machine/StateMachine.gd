extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}
var shared_state: SharedState

func _ready():

    shared_state = SharedState.new()
    shared_state.target = null

    for child in get_children():
        if child is State:
            states[child.name] = child
            child.transition.connect(handle_transition)

    if initial_state:
        initial_state.enter(shared_state)
        current_state = initial_state


func _physics_process(delta):
    if current_state:
        current_state.physics_process(delta)

func handle_transition(state: State, new_state_name: String, body: Node2D):

    print("transitioning from ", state.name, " to ", new_state_name)

    var new_state = states.get(new_state_name, current_state)

    if current_state and current_state != new_state:
        current_state.exit()

        shared_state.target = body

        new_state.enter(shared_state)

        current_state = new_state
