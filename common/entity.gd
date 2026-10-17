class_name Entity
extends CharacterBody2D

signal direction_changed(entity: Entity, direction: Entity.Direction)

enum Direction {
	SOUTH,
	WEST,
	NORTH,
	EAST,
}

@export var sprite: TopdownSprite
@export var pushable: Pushable
@export var state_machine: StateMachine

var direction: Direction = Direction.SOUTH:
	set(value):
		if value != direction:
			direction = value
			sprite.flip_h = direction == Direction.WEST
			direction_changed.emit(self, value)


func _physics_process(delta: float) -> void:
	if state_machine != null:
		state_machine.update(delta)
