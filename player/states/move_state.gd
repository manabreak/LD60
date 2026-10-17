class_name MoveState
extends State

const SPEED = 29.0
const SPEED_PUSH = 29.0
const PUSH_DIR_MARGIN = 0.5

@export var player: Player
@export var sprite: TopdownSprite


func enter() -> void:
	sprite.play_anim("walk")


func update(delta: float) -> void:
	var pushing = player.detected_pushable != null && player.has_skill(Skill.SkillType.PUSH)
	# Log.d("Pushing: %s" % pushing)
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.is_zero_approx():
		player.velocity = Vector2.ZERO
		machine.request_state("IdleState")
		if player.detected_pushable != null:
			player.detected_pushable.velocity = Vector2.ZERO
	else:
		sprite.flip_h = direction.x < 0.0
		var speed = SPEED_PUSH if pushing else SPEED
		player.velocity = direction.normalized() * speed
		player.update_direction(direction)
		player.move_and_slide()
	
		if pushing:
			var dir_to_box = (player.detected_pushable.position - player.position).normalized()
			var push_direction = Vector2(0, 1)
			if dir_to_box.y < -PUSH_DIR_MARGIN:
				push_direction = Vector2(0, -1)
			elif dir_to_box.x > PUSH_DIR_MARGIN:
				push_direction = Vector2(1, 0)
			elif dir_to_box.x < -PUSH_DIR_MARGIN:
				push_direction = Vector2(-1, 0)
			
			if abs(direction.angle_to(dir_to_box)) < 1.0:
				player.detected_pushable.velocity = push_direction * SPEED_PUSH
			else:
				player.detected_pushable.velocity = Vector2.ZERO
