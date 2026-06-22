extends Node3D

# Public excerpt:
# First-person bow controller sample. The full private project includes more
# mesh setup, animation probing, validation fields, and runtime checks.

const ArrowProjectile = preload("res://scripts/arrow_projectile.gd")

const SHOOT_COOLDOWN := 0.28
const DRAW_TIME := 0.45
const AIM_RANGE := 60.0
const PROJECTILE_MIN_SPEED := 5.0
const PROJECTILE_MAX_SPEED := 34.0

var camera: Camera3D
var shooter: Node3D
var arrow_preview: Node3D
var shoot_cooldown := 0.0
var draw_amount := 0.0
var is_drawing := false
var last_fire_start_position := Vector3.ZERO
var last_fire_direction := Vector3.FORWARD
var last_fire_power := 0.0
var last_projectile_speed := 0.0
var last_projectile_max_distance := 0.0
var last_projectile_damage := 0.0
var last_attack_result := {}
var last_aim_has_hit := false
var last_aim_target_name := ""
var last_aim_point := Vector3.ZERO


func setup(owner_body: Node3D, view_camera: Camera3D) -> void:
	shooter = owner_body
	camera = view_camera


func _physics_process(delta: float) -> void:
	shoot_cooldown = maxf(shoot_cooldown - delta, 0.0)
	if is_drawing:
		draw_amount = minf(draw_amount + (delta / DRAW_TIME), 1.0)
	_update_aim_state()
	_update_draw_visuals()


func begin_draw() -> void:
	if camera == null or shooter == null or shoot_cooldown > 0.0:
		return
	is_drawing = true
	if arrow_preview != null:
		arrow_preview.visible = true


func release_draw() -> void:
	if not is_drawing:
		return
	is_drawing = false
	if shoot_cooldown <= 0.0:
		_fire_arrow()
	draw_amount = 0.0
	_update_draw_visuals()


func _fire_arrow() -> void:
	shoot_cooldown = SHOOT_COOLDOWN
	var fire_power := clampf(draw_amount, 0.0, 1.0)
	var arrow := Node3D.new()
	arrow.name = "ArrowProjectile"
	arrow.set_script(ArrowProjectile)
	get_tree().current_scene.add_child(arrow)
	var start := arrow_preview.global_position if arrow_preview != null else camera.global_position + (-camera.global_transform.basis.z * 0.75)
	var direction := _get_fire_direction(start, fire_power)
	last_fire_start_position = start
	last_fire_direction = direction
	last_fire_power = fire_power
	last_attack_result = _build_attack_result(fire_power)
	arrow.call("setup", start, direction, [shooter], fire_power, last_attack_result)
	last_projectile_speed = arrow.get("speed")
	last_projectile_max_distance = arrow.get("max_distance")
	last_projectile_damage = arrow.get("damage")


func _build_attack_result(fire_power: float) -> Dictionary:
	var session := _get_session()
	if session != null and session.has_method("build_player_attack_result"):
		return session.call("build_player_attack_result", fire_power)
	return {
		"damage": lerpf(3.0, 28.0, fire_power * fire_power),
		"is_critical": false,
		"power": fire_power,
	}


func _get_fire_direction(start: Vector3, fire_power: float) -> Vector3:
	var aim_target := camera.global_position + (-camera.global_transform.basis.z * AIM_RANGE)
	if last_aim_has_hit:
		aim_target = last_aim_point
	var direct := (aim_target - start).normalized()
	var lifted := direct.lerp(Vector3.UP, clampf((1.0 - fire_power) * 0.08, 0.0, 0.08))
	return lifted.normalized()


func _update_aim_state() -> void:
	if camera == null:
		return
	var space := get_world_3d().direct_space_state
	var from := camera.global_position
	var to := from + (-camera.global_transform.basis.z * AIM_RANGE)
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [shooter]
	var hit := space.intersect_ray(query)
	last_aim_has_hit = not hit.is_empty()
	last_aim_point = hit.get("position", to)
	var collider = hit.get("collider")
	last_aim_target_name = collider.name if collider is Node else ""


func _update_draw_visuals() -> void:
	if arrow_preview == null:
		return
	arrow_preview.visible = is_drawing
	arrow_preview.position.x = lerpf(0.02, -0.30, draw_amount)


func _get_session() -> Node:
	return get_tree().current_scene.find_child("GameSession", true, false) if get_tree().current_scene != null else null
