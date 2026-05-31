class_name MdsInteractSkill3D extends Area3D

@export var parent: Node3D
@export var shape: Shape3D = preload("res://addons/mds_lib/skills/interact/mds_interact_skill_3d_default_shape.tres")
@export var interact_action: String = "interact"

func _ready():
	if shape != null:
		%Shape.shape = shape

var should_interact: bool = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(interact_action):
		should_interact = true

func _physics_process(delta: float) -> void:
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if should_interact:
		should_interact = false
		# TODO: Only one ?
		for interact_target in get_overlapping_areas():
			if interact_target is MdsInteractTarget3D:
				print("should interact")
				interact_target.interact(parent)
