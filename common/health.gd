class_name Health
extends Resource

signal health_changed(old_health: int, new_health: int)
signal died

@export var health: int = 1
@export var max_health: int = 1
@export var vulnerability_time: float = 0.25

var vulnerability_timer = 0.0

func update(delta: float) -> void:
	if vulnerability_timer > 0.0:
		vulnerability_timer -= delta


func damage(amount: int) -> void:
	if vulnerability_timer > 0.0:
		return
	if amount <= 0:
		return
	if health <= 0:
		return
	
	vulnerability_timer = vulnerability_time
	var old_health = health
	health -= amount
	health_changed.emit(old_health, health)
	if health <= 0:
		died.emit()


func heal(amount: int) -> void:
	if amount <= 0:
		return
	if health == max_health:
		return
	
	var old_health = health
	health += amount
	if health > max_health:
		health = max_health
	health_changed.emit(old_health, health)
