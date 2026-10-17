class_name GameController
extends Node2D

@export var player: Player
@export var skill_view: Control
@export var skill_label: Label
@export var hearts: HeartsUI
var levels: Array[Node2D]

func _ready() -> void:
	for level in $LevelNode.get_children():
		levels.append(level)
	enable_level(0)
	
	player.health.health_changed.connect(self.on_player_health_changed)
	player.health.died.connect(self.on_player_died)


func enable_level(level: int) -> void:
	for old_level in levels:
		$LevelNode.remove_child(old_level)
	$LevelNode.add_child(levels[level])


func on_player_health_changed(old_health: int, new_health: int) -> void:
	hearts.update_hearts(old_health, new_health)


func on_player_died() -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func start_game() -> void:
	player.state_machine.request_state("RotationState")
	skill_view.visible = true
	skill_label.text = "Booting..."
	
	var tween = create_tween()
	tween.tween_property(skill_label, "visible_ratio", 0.0, 0.0)
	tween.tween_property(skill_label, "visible_ratio", 1.0, 1.0)
	tween.tween_property(skill_label, "visible_ratio", 0.0, 0.2).set_delay(0.3)
	await tween.finished
	
	skill_label.text = "SYSTEM OPERATIONAL"
	tween = create_tween()
	tween.tween_property(skill_label, "visible_ratio", 0.0, 0.0)
	tween.tween_property(skill_label, "visible_ratio", 1.0, 0.2)
	tween.tween_property(skill_label, "visible_ratio", 0.0, 0.2).set_delay(2.0)
	player.state_machine.request_state("IdleState")
	
	await tween.finished
	skill_view.visible = false


func grant_skill(skill: Skill) -> void:
	if player.has_skill(skill.type):
		return
	
	player.grant_skill(skill)
	player.state_machine.request_state("GrantSkillState")
	skill_view.visible = true
	skill_label.text = "PROGRAM FOUND!"
	skill_label.visible_ratio = 1.0
	await get_tree().create_timer(2.0).timeout
	
	player.state_machine.request_state("RotationState")
	skill_label.text = "Installing %s" % skill.name
	await get_tree().create_timer(2.0).timeout
	
	if skill.type == Skill.SkillType.LEVEL:
		var level = skill.level
		enable_level(level)
	
	player.state_machine.request_state("IdleState")
	skill_view.visible = false
