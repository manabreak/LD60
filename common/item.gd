class_name Item
extends Area2D

var collected = false

func _ready() -> void:
	self.body_entered.connect(self.on_body_entered)


func on_body_entered(body: Node2D) -> void:
	if collected:
		return
	
	if body is Player:
		collected = true
		collect()


func collect() -> void:
	pass
