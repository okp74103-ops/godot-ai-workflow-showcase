extends RefCounted
class_name FptSkillCatalog

# Public excerpt:
# Role boundary:
# - Owns reusable skill definitions.
# - Does not own player input, cooldown timers, UI layout, or combat execution.

const ACTIVE_SKILL_IDS := [
	"double_shot",
	"triple_shot",
	"multi_shot",
	"critical_boost",
	"grenade_barrage",
]

const DEFINITIONS := {
	"double_shot": {
		"display_name": "Double Shot",
		"cooldown": 0.0,
		"stamina_cost": 12.0,
		"hold_repeat": true,
		"mouse_aim": true,
	},
	"critical_boost": {
		"display_name": "Critical Boost",
		"cooldown": 8.0,
		"stamina_cost": 10.0,
		"hold_repeat": false,
		"mouse_aim": false,
	},
	"grenade_barrage": {
		"display_name": "Grenade Barrage",
		"cooldown": 15.0,
		"stamina_cost": 35.0,
		"hold_repeat": false,
		"mouse_aim": true,
	},
}


static func get_active_skill_ids() -> Array:
	return ACTIVE_SKILL_IDS.duplicate()


static func get_definition(skill_id: String) -> Dictionary:
	return DEFINITIONS.get(skill_id, {}).duplicate(true)


static func is_active_skill(skill_id: String) -> bool:
	return DEFINITIONS.has(skill_id)


static func get_display_name(skill_id: String) -> String:
	return String(get_definition(skill_id).get("display_name", skill_id))


static func get_cooldown(skill_id: String) -> float:
	return maxf(float(get_definition(skill_id).get("cooldown", 0.0)), 0.0)


static func get_stamina_cost(skill_id: String) -> float:
	return maxf(float(get_definition(skill_id).get("stamina_cost", 0.0)), 0.0)


static func is_hold_repeat_skill(skill_id: String) -> bool:
	return bool(get_definition(skill_id).get("hold_repeat", false))


static func is_mouse_aim_skill(skill_id: String) -> bool:
	return bool(get_definition(skill_id).get("mouse_aim", false))
