class_name Box
extends Entity


func _ready() -> void:
	super._ready()
	self.health.health_changed.connect(self.on_health_changed)


func on_health_changed(old_health: int, new_health: int) -> void:
	if new_health < old_health:
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color.RED, 0.0)
		tween.tween_property(self, "modulate", Color.WHITE, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
