class_name Player
extends Entity

const DIR_MARGIN = 0.1

@export var state_machine: StateMachine


func _physics_process(delta: float) -> void:
	state_machine.update(delta)


func update_direction(v: Vector2) -> void:
	if v.y > DIR_MARGIN:
		direction = Entity.Direction.SOUTH
	elif v.y < -DIR_MARGIN:
		direction = Entity.Direction.NORTH
	elif v.x > DIR_MARGIN:
		direction = Entity.Direction.EAST
	elif v.x < -DIR_MARGIN:
		direction = Entity.Direction.WEST
