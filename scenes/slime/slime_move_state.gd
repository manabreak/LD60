class_name SlimeMoveState
extends State

@export var slime: Entity

var direction: Vector2 = Vector2.ZERO
var move_timer = 0.0


func enter() -> void:
	direction = Vector2(1, 0).rotated(randf_range(0, PI * 2.0))
	move_timer = randf_range(1.0, 1.5)


func update(delta: float) -> void:
	move_timer -= delta
	slime.velocity = direction * 10.0
	slime.move_and_slide()
	if move_timer <= 0.0:
		machine.request_state("SlimeIdleState")
