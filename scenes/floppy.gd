class_name Floppy
extends Item

@export var game_controller: GameController
@export var granted_skill: Skill


func collect() -> void:
	game_controller.grant_skill(granted_skill)
	queue_free()
