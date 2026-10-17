class_name Entity
extends CharacterBody2D

signal direction_changed(entity: Entity, direction: Entity.Direction)

enum Direction {
	SOUTH,
	NORTH,
	EAST,
	WEST
}

var direction: Direction = Direction.SOUTH:
	set(value):
		if value != direction:
			direction = value
			direction_changed.emit(self, value)
