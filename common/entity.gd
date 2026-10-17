class_name Entity
extends CharacterBody2D

signal direction_changed(entity: Entity, direction: Entity.Direction)

enum Direction {
	SOUTH,
	WEST,
	NORTH,
	EAST,
}

@export var player: Player
@export var static_sprite: Sprite2D
@export var sprite: TopdownSprite
@export var state_machine: StateMachine
@export var health: Health

var direction: Direction = Direction.SOUTH:
	set(value):
		if value != direction:
			direction = value
			sprite.flip_h = direction == Direction.WEST
			direction_changed.emit(self, value)


func _ready() -> void:
	if health != null:
		health = health.duplicate()
		health.died.connect(self.on_died)


func on_died() -> void:
	Log.d("%s died" % self.name)
	queue_free()


func _process(delta: float) -> void:
	if health != null:
		health.update(delta)


func _physics_process(delta: float) -> void:
	if state_machine != null:
		state_machine.update(delta)
