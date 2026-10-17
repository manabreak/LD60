class_name RotationState
extends State

@export var player: Player
@export var sprite: TopdownSprite

var tween: Tween = null
var d: int = 2

func enter() -> void:
	sprite.play_anim("idle")
	tween = create_tween()
	tween.set_loops()
	tween.tween_callback(self.change_direction).set_delay(0.2)


func exit() -> void:
	tween.stop()


func change_direction() -> void:
	d += 1
	if d > 3:
		d = 0
	player.direction = d
