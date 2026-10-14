class_name State
extends Node

var machine: StateMachine

func enter() -> void:
	pass


func exit() -> void:
	pass


func update(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if machine.current_state == self:
		on_input(event)


func on_input(event: InputEvent) -> void:
	pass
