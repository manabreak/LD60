class_name Health
extends Resource

signal health_changed
signal died

@export var health: int = 1
@export var max_health: int = 1


func damage(amount: int) -> void:
	Log.d("Damaging for %d" % amount)
	if amount <= 0:
		return
	if health <= 0:
		return
	
	health -= amount
	health_changed.emit()
	if health <= 0:
		Log.d("Died")
		died.emit()


func heal(amount: int) -> void:
	if amount <= 0:
		return
	if health == max_health:
		return
	
	health += amount
	if health > max_health:
		health = max_health
	health_changed.emit()
