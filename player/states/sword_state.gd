class_name SwordState
extends State

@export var player: Player
@export var player_sprite: TopdownSprite
@export var sword_sprite: TopdownSprite


func enter() -> void:
	player.sword_collision_shape.disabled = false
	sword_sprite.visible = true
	sword_sprite.flip_h = player_sprite.flip_h
	player_sprite.play_anim("sword")
	sword_sprite.play_anim("sword")
	await sword_sprite.animation_finished
	sword_sprite.visible = false
	player.sword_collision_shape.disabled = true
	machine.request_state("IdleState")
