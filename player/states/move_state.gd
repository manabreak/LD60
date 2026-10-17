class_name MoveState
extends State

const SPEED = 29.0
const SPEED_PUSH = 16.0
const PUSH_DIR_MARGIN = 0.5

@export var player: Player
@export var sprite: TopdownSprite


func enter() -> void:
	sprite.play_anim("walk")


func update(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.is_zero_approx():
		player.velocity = Vector2.ZERO
		machine.request_state("IdleState")
	else:
		sprite.flip_h = direction.x < 0.0
		var speed = SPEED
		player.velocity = direction.normalized() * speed
		player.update_direction(direction)
		player.move_and_slide()
