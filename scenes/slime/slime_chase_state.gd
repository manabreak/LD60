class_name SlimeChaseState
extends State

const SLIME_CHASE_END_RANGE = 48.0

@export var slime: Entity

var move_timer = 0.0

func enter() -> void:
	move_timer = 3.0


func update(delta: float) -> void:
	move_timer -= delta
	var dir = (slime.player.position - slime.position).normalized()
	slime.velocity = dir * 16.0
	slime.move_and_slide()
	
	if slime.position.distance_to(slime.player.position) > SLIME_CHASE_END_RANGE || move_timer <= 0.0:
		machine.request_state("SlimeIdleState")
