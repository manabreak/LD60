class_name MoveState
extends State

const SPEED = 32.0

@export var player: Player
@export var sprite: TopdownSprite


func enter() -> void:
	sprite.play_anim("walk")


func update(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.is_zero_approx():
		machine.request_state("IdleState")
	else:
		sprite.flip_h = direction.x < 0.0
		player.velocity = direction.normalized() * SPEED
		player.update_direction(direction)
		player.move_and_slide()
