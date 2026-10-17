class_name TopdownSprite
extends AnimatedSprite2D

@export var entity: Entity

var current_animation: String = ""


func _ready() -> void:
	entity.direction_changed.connect(self.on_direction_changed)


func on_direction_changed(entity: Entity, direction: Entity.Direction) -> void:
	if current_animation != "":
		Log.d("Direction changed for animation: %s" % direction)
		play(current_animation + "_" + get_direction_string(direction))


func get_direction_string(direction: Entity.Direction) -> String:
	match direction:
		Entity.Direction.NORTH:
			return "north"
		Entity.Direction.EAST:
			return "east"
		Entity.Direction.WEST:
			return "east"
	return "south"


func play_anim(name: String) -> void:
	play(name + "_" + get_direction_string(entity.direction))
	self.current_animation = name
