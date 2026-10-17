class_name Floppy
extends Item

@export var granted_skill: Skill


func _ready() -> void:
	self.body_entered.connect(self.on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if collected:
		return
	
	if body is Player:
		Log.d("Pick up floppy %s" % granted_skill.name)
		collected = true
		var player = body as Player
		player.grant_skill(granted_skill)
		queue_free()
