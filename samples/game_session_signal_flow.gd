extends Node

# Public excerpt:
# Signal-centered session state. This demonstrates how runtime systems can
# communicate without placing all owned state in one global manager.

const PlayerLeveling := preload("res://scripts/player/player_leveling.gd")

signal target_hit_count_changed(hit_count: int)
signal target_damage_changed(total_damage: float, last_damage: float, last_power: float)
signal player_status_changed(snapshot: Dictionary)
signal player_leveled_up(level: int, stat_points: int)
signal player_resources_changed(snapshot: Dictionary)
signal skill_hotkeys_changed(bindings: Array)
signal selected_skill_changed(skill_id: String)
signal active_skill_cooldown_changed(skill_id: String, time_left: float, max_time: float)
signal active_skill_cast(skill_id: String)

var target_hit_count := 0
var total_target_damage := 0.0
var leveling: FptPlayerLeveling
var player_resource_snapshot := {
	"hp": 100.0,
	"max_hp": 100.0,
	"stamina": 100.0,
	"max_stamina": 100.0,
}
var skill_hotkey_bindings: Array = []
var selected_skill_id := ""
var active_skill_cooldowns: Dictionary = {}


func _ready() -> void:
	leveling = PlayerLeveling.new()
	leveling.name = "PlayerLeveling"
	add_child(leveling)
	leveling.level_changed.connect(_on_level_changed)
	leveling.exp_changed.connect(_on_progress_changed)
	leveling.stats_changed.connect(_on_stats_changed)
	leveling.call_deferred("setup", null)


func register_target_hit(hit_damage: float = 1.0, hit_power: float = 1.0) -> void:
	target_hit_count += 1
	total_target_damage += maxf(hit_damage, 0.0)
	target_hit_count_changed.emit(target_hit_count)
	target_damage_changed.emit(total_target_damage, hit_damage, hit_power)
	if leveling == null:
		return
	var gained_levels := leveling.add_player_exp(18.0 + hit_damage * 0.25)
	leveling.add_main_stat_exp("dex", 8.0 * maxf(hit_power, 0.25))
	if gained_levels > 0:
		player_leveled_up.emit(leveling.player_level, leveling.stat_points)
	player_status_changed.emit(leveling.get_status_snapshot())


func update_player_resources(snapshot: Dictionary) -> void:
	player_resource_snapshot = {
		"hp": float(snapshot.get("hp", player_resource_snapshot.get("hp", 100.0))),
		"max_hp": maxf(float(snapshot.get("max_hp", player_resource_snapshot.get("max_hp", 100.0))), 1.0),
		"stamina": float(snapshot.get("stamina", player_resource_snapshot.get("stamina", 100.0))),
		"max_stamina": maxf(float(snapshot.get("max_stamina", player_resource_snapshot.get("max_stamina", 100.0))), 1.0),
	}
	player_resources_changed.emit(player_resource_snapshot)


func update_selected_skill(skill_id: String) -> void:
	selected_skill_id = skill_id
	selected_skill_changed.emit(selected_skill_id)


func update_active_skill_cooldown(skill_id: String, time_left: float, max_time: float) -> void:
	if skill_id.is_empty():
		return
	active_skill_cooldowns[skill_id] = {
		"time_left": maxf(time_left, 0.0),
		"max_time": maxf(max_time, 0.0),
	}
	active_skill_cooldown_changed.emit(skill_id, time_left, max_time)


func _on_level_changed(level: int, stat_points: int) -> void:
	player_leveled_up.emit(level, stat_points)


func _on_progress_changed(_exp: float, _required_exp: float) -> void:
	if leveling != null:
		player_status_changed.emit(leveling.get_status_snapshot())


func _on_stats_changed(snapshot: Dictionary) -> void:
	player_status_changed.emit(snapshot)
