class_name BoxIdleState
extends State

@export var box: Entity


func update(delta: float) -> void:
	if !box.velocity.is_zero_approx():
		machine.request_state("BoxMoveState")
		box.move_and_slide()
