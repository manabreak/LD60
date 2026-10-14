class_name Transition
extends Node

@export var from_state: State
@export var to_state: State


func can_transition(machine: StateMachine, from: State, to: State) -> bool:
	return true


func run(machine: StateMachine, from: State, to: State) -> void:
	pass
