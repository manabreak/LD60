class_name SlimeIdleState
extends State

const SLIME_CHASE_START_RANGE = 32.0

# @export var player: Player
@export var slime: Entity
@export var sprite: TopdownSprite


func enter() -> void:
	sprite.play_anim("default")
	await get_tree().create_timer(randf_range(1.0, 2.0)).timeout
	
	if slime.position.distance_to(slime.player.position) < SLIME_CHASE_START_RANGE:
		machine.request_state("SlimeChaseState")
	else:
		machine.request_state("SlimeMoveState")
