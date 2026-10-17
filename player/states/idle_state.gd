class_name IdleState
extends State

@export var player: Player
@export var sprite: TopdownSprite


func enter() -> void:
	sprite.play_anim("idle")


func update(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if !direction.is_zero_approx():
		player.update_direction(direction)
		sprite.flip_h = direction.x < 0.0
		sprite.play_anim("walk")
		machine.request_state("MoveState")
	
