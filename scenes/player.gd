class_name Player
extends Entity

const DIR_MARGIN = 0.1

@export var skills: Array[Skill]
@export var push_sensor_offsets: Dictionary[Entity.Direction, Vector2]
@export var push_sensor: Area2D

var detected_pushable: Entity = null

func _ready() -> void:
	push_sensor.body_entered.connect(self.on_push_sensor_body_entered)
	push_sensor.body_exited.connect(self.on_push_sensor_body_exited)


func on_push_sensor_body_entered(body: Node2D) -> void:
	if body is Entity:
		if body.pushable != null:
			detected_pushable = body


func on_push_sensor_body_exited(body: Node2D) -> void:
	if body == detected_pushable:
		detected_pushable = null


func grant_skill(skill: Skill) -> void:
	skills.append(skill)
	Log.d("Player got skill %s" % skill.name)


func has_skill(type: Skill.SkillType) -> bool:
	for skill in skills:
		if skill.type == type:
			return true
	return false


func update_direction(v: Vector2) -> void:
	if v.y > DIR_MARGIN:
		direction = Entity.Direction.SOUTH
		push_sensor.position = push_sensor_offsets[direction]
	elif v.y < -DIR_MARGIN:
		direction = Entity.Direction.NORTH
		push_sensor.position = push_sensor_offsets[direction]
	elif v.x > DIR_MARGIN:
		direction = Entity.Direction.EAST
		push_sensor.position = push_sensor_offsets[direction]
	elif v.x < -DIR_MARGIN:
		direction = Entity.Direction.WEST
		push_sensor.position = push_sensor_offsets[direction]
