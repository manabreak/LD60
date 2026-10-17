class_name BoxMoveState
extends State

@export var box: Entity


func update(delta: float) -> void:
	if box.velocity.is_zero_approx():
		machine.request_state("BoxIdleState")
	else:
		Log.d("Box velocity: %s" % box.velocity)
		box.move_and_slide()
