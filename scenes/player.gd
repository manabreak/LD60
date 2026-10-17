class_name Player
extends Entity

const DIR_MARGIN = 0.1

@export var skills: Array[Skill]
@export var sword_sensor_offsets: Dictionary[Entity.Direction, Vector2]
@export var sword_sensor: Area2D
@export var sword_collision_shape: CollisionShape2D

func _ready() -> void:
	sword_collision_shape.disabled = true
	sword_sensor.body_entered.connect(self.on_sword_entered)


func on_sword_entered(body: Node2D) -> void:
	if body is Entity && body != self:
		Log.d("Sword hit entity: %s" % body.name)
		var e = body as Entity
		if e.health != null:
			e.health.damage(1)


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
		sword_sensor.position = sword_sensor_offsets[direction]
	elif v.y < -DIR_MARGIN:
		direction = Entity.Direction.NORTH
		sword_sensor.position = sword_sensor_offsets[direction]
	elif v.x > DIR_MARGIN:
		direction = Entity.Direction.EAST
		sword_sensor.position = sword_sensor_offsets[direction]
	elif v.x < -DIR_MARGIN:
		direction = Entity.Direction.WEST
		sword_sensor.position = sword_sensor_offsets[direction]


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if Input.is_action_just_pressed("attack") && has_skill(Skill.SkillType.SWORD):
		state_machine.request_state("SwordState")
