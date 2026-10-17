class_name Skill
extends Resource

enum SkillType {
	NONE,
	SWORD,
	LEVEL,
}

@export var name: String
@export var type: SkillType = SkillType.NONE
@export var level: int = -1
