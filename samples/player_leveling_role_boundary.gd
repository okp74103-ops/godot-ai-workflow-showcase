extends Node
class_name FptPlayerLeveling

# Public excerpt:
# Role boundary:
# - Owns player level, EXP, stat points, and skill EXP records.
# - Does not own combat execution, equipment storage, save file IO, or HUD rendering.

signal level_changed(level: int, stat_points: int)
signal exp_changed(exp: float, required_exp: float)
signal stats_changed(snapshot: Dictionary)

const PLAYER_LEVEL_EXP_BASE := 120.0
const PLAYER_LEVEL_EXP_GROWTH := 1.22
const STAT_POINTS_PER_LEVEL := 3
const MAIN_STAT_EXP_BASE := 150.0
const MAIN_STAT_EXP_GROWTH := 1.12
const MAIN_STAT_MAX_LEVEL := 80

var owner_player: Node
var player_level := 1
var player_exp := 0.0
var stat_points := 0
var weapon_damage := 0.0
var equipment_bonus_damage := 0.0
var stat_values := {
	"str": 10,
	"dex": 10,
	"vit": 10,
}
var main_stat_exp := {
	"str": 0.0,
	"dex": 0.0,
	"vit": 0.0,
}
var damage := 0.0
var crit_chance := 5.0
var crit_damage_multiplier := 1.5


func setup(player: Node) -> void:
	owner_player = player
	recalculate_stats()
	_emit_stats_changed()


func add_player_exp(amount: float) -> int:
	if amount <= 0.0:
		return 0
	player_exp += amount
	var gained_levels := 0
	while player_exp >= get_required_player_exp():
		player_exp -= get_required_player_exp()
		player_level += 1
		stat_points += STAT_POINTS_PER_LEVEL
		gained_levels += 1
		level_changed.emit(player_level, stat_points)
	exp_changed.emit(player_exp, get_required_player_exp())
	_emit_stats_changed()
	return gained_levels


func apply_stat_point(stat_id: String) -> bool:
	if stat_points <= 0 or not stat_values.has(stat_id):
		return false
	stat_points -= 1
	stat_values[stat_id] = int(stat_values[stat_id]) + 1
	recalculate_stats()
	level_changed.emit(player_level, stat_points)
	_emit_stats_changed()
	return true


func add_main_stat_exp(stat_id: String, amount: float) -> int:
	if amount <= 0.0 or not stat_values.has(stat_id):
		return 0
	main_stat_exp[stat_id] = float(main_stat_exp.get(stat_id, 0.0)) + amount
	var gained_stats := 0
	while int(stat_values[stat_id]) < MAIN_STAT_MAX_LEVEL and float(main_stat_exp[stat_id]) >= get_required_main_stat_exp_for_stat(stat_id):
		main_stat_exp[stat_id] -= get_required_main_stat_exp_for_stat(stat_id)
		stat_values[stat_id] = int(stat_values[stat_id]) + 1
		gained_stats += 1
	recalculate_stats()
	_emit_stats_changed()
	return gained_stats


func get_required_player_exp() -> float:
	return PLAYER_LEVEL_EXP_BASE * pow(PLAYER_LEVEL_EXP_GROWTH, float(player_level - 1))


func get_required_main_stat_exp_for_stat(stat_id: String) -> float:
	var stat_value := int(stat_values.get(stat_id, 10))
	return MAIN_STAT_EXP_BASE * pow(MAIN_STAT_EXP_GROWTH, float(stat_value - 10))


func recalculate_stats() -> void:
	damage = weapon_damage + equipment_bonus_damage + float(stat_values.get("str", 10)) * 1.7


func build_attack_result(shot_power: float = 1.0) -> Dictionary:
	var is_critical := randf() * 100.0 < crit_chance
	var final_damage := damage * crit_damage_multiplier if is_critical else damage
	return {
		"damage": final_damage,
		"is_critical": is_critical,
		"power": clampf(shot_power, 0.0, 1.0),
	}


func get_status_snapshot() -> Dictionary:
	return {
		"level": player_level,
		"exp": player_exp,
		"required_exp": get_required_player_exp(),
		"stat_points": stat_points,
		"stats": stat_values.duplicate(true),
		"damage": damage,
	}


func _emit_stats_changed() -> void:
	stats_changed.emit(get_status_snapshot())
