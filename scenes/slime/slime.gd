class_name Slime
extends Entity

var damaging = false


func _ready() -> void:
	super._ready()
	self.health.health_changed.connect(self.on_health_changed)
	$DamageArea.body_entered.connect(self.on_dmg_body_entered)
	$DamageArea.body_exited.connect(self.on_dmg_body_exited)


func on_dmg_body_entered(body: Node2D) -> void:
	if body is Player:
		damaging = true


func on_dmg_body_exited(body: Node2D) -> void:
	if body is Player:
		damaging = false


func _process(delta: float) -> void:
	super._process(delta)
	if damaging:
		player.health.damage(1)


func on_health_changed(old_health: int, new_health: int) -> void:
	if new_health < old_health:
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color.RED, 0.0)
		tween.tween_property(self, "modulate", Color.WHITE, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
