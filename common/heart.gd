class_name Heart
extends Item

@export var player: Player


func collect() -> void:
	if player.health.health < player.health.max_health:
		player.health.heal(1)
		queue_free()
	else:
		collected = false
