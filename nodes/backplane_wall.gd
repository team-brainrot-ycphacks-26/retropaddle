@tool
class_name BackplaneWall
extends Node3D

signal ball_hit(wall: BackplaneWall)

@export var target_node: Node3D

@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D

var _player: Player = null

var player: Player:
	get:
		return _player
	set(value):
		var old_player = _player
		_player = value

		_player_changed(old_player, value)


func _player_changed(_old_player: Player, _new_player: Player) -> void:
	pass


func _process(_delta: float) -> void:
	if not mesh_instance_3d or not mesh_instance_3d.mesh:
		return

	if not is_instance_valid(target_node) or not target_node.is_inside_tree():
		return

	var shader_material = mesh_instance_3d.material_override as ShaderMaterial

	if not shader_material:
		return

	var local_position = mesh_instance_3d.to_local(target_node.global_position)
	var aabb = mesh_instance_3d.get_aabb()

	var closest_point = Vector3(
		clampf(local_position.x, aabb.position.x, aabb.end.x),
		clampf(local_position.y, aabb.position.y, aabb.end.y),
		clampf(local_position.z, aabb.position.z, aabb.end.z),
	)

	shader_material.set_shader_parameter("mask_origin", closest_point)


func _on_collision_area_body_entered(body: Node3D) -> void:
	if not multiplayer.is_server():
		return

	# Filter for ball (can change for more specific condition when ball is created)
	if body is not RigidBody3D:
		return

	print("Ball hit: ", name)
	ball_hit.emit(self)
