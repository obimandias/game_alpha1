extends Node
class_name State

signal transition(state: State, new_state_name: String, data: Node2D)

func enter(shared_state: SharedState):
    pass

func exit():
    pass

func physics_process(delta):
    pass
