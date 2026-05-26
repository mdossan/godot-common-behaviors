class_name MdsUseItemSkill3D
extends Node3D

@export var parent: Node3D = null
@export var use_action: String = "use"
@export var item_to_use: MdsItem3D = null

var _should_use: bool = false

func _input(event: InputEvent) -> void:
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if event.is_action_pressed(use_action):
		_should_use = true

func _physics_process(_delta: float) -> void:
	if !_should_use:
		return
	
	# Item usage is a "one time" input
	_should_use = false
	
	if !is_instance_valid(item_to_use):
		return
	
	var usage: MdsItemUsage = item_to_use.item_resource.usage
	usage.use(item_to_use, parent)
	
