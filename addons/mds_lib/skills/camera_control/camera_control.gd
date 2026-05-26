class_name MdsCameraControl
extends Node3D

@export var node_vertical: Node3D
@export var node_horizontal: Node3D

var current_rot = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		return
	
	if event is InputEventMouseMotion:
		current_rot.x = current_rot.x - event.relative.x
		current_rot.y = clamp(current_rot.y - event.relative.y, -90, 35)
		node_vertical.rotation.x = deg_to_rad(current_rot.y)
		node_horizontal.rotation.y = deg_to_rad(current_rot.x)
