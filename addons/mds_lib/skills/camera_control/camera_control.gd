class_name MdsCameraControl
extends Node3D

@export var free_mode: bool = true
@export var node_vertical: Node3D
@export var node_horizontal: Node3D
@export var hard_vertical: Node3D
@export var hard_horizontal: Node3D
@export var disabled: bool = false

var current_rot = Vector2.ZERO
var free_mode_rot = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		return
	
	if disabled:
		return
	
	if event is InputEventMouseMotion:
		free_mode_rot.x = free_mode_rot.x - event.relative.x
		free_mode_rot.y = clamp(free_mode_rot.y - event.relative.y, -90, 35)
		current_rot.x = current_rot.x - event.relative.x
		current_rot.y = clamp(current_rot.y - event.relative.y, -90, 35)

func _process(delta: float) -> void:
	if free_mode:
		node_vertical.rotation.x = deg_to_rad(free_mode_rot.y)
		node_horizontal.rotation.y = deg_to_rad(free_mode_rot.x)
	else:
		node_vertical.rotation.x = deg_to_rad(0.0)
		node_horizontal.rotation.y = deg_to_rad(0.0)
		free_mode_rot.x = 0.0
		free_mode_rot.y = 0.0
		hard_horizontal.rotation.y = deg_to_rad(current_rot.x)
