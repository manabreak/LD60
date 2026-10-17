class_name Skill
extends Resource

enum SkillType {
	NONE,
	PUSH,
}

@export var name: String
@export var type: SkillType = SkillType.NONE
