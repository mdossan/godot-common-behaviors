class_name TestBenchSingleCustomInteraction extends Node3D

var interaction_registered: bool = false
var interactable_node: MdsInteractTarget3D
var interact_node: MdsInteractSkill3D
var custom_interaction: MdsInteractCustom

func _ready() -> void:
	interactable_node = %MdsInteractTarget3D
	interact_node = %MdsInteractSkill3D
	custom_interaction = %MdsInteractionCustom

func _on_interaction(actor: Node):
	interaction_registered = true
