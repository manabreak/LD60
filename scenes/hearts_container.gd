class_name HeartsUI
extends HBoxContainer

@export var hearts: Array[Control]


func update_hearts(old_health: int, new_health: int) -> void:
	for i in range(hearts.size()):
		if i < new_health:
			hearts[i].modulate = Color.WHITE
		else:
			hearts[i].modulate = Color.DIM_GRAY
