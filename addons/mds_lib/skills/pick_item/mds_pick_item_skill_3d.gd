@tool
class_name MdsPickItemSkill3D extends Area3D

signal picked(item: MdsItem3D)

@export var disabled: bool = false
@export var parent: Node3D:
	set(node):
		if parent != node:
			parent = node
			update_configuration_warnings()
@export var shape: Shape3D:
	set(new_shape):
		shape = new_shape
		if Engine.is_editor_hint():
			%Shape.shape = shape
@export var pick_action: String = "pick"

func _get_configuration_warnings():
	var warnings: Array[String] = []
	if parent == null:
		warnings.push_back("'parent' must be defined")
	return warnings

var pickable_items: Dictionary[String, MdsPickTarget3D] = {}

func _ready():
	if Engine.is_editor_hint():
		return;
	
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if shape != null:
		%Shape.shape = shape

var should_pick: bool = false;

func _input(event: InputEvent) -> void:
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if disabled:
		return
	
	if event.is_action_pressed(pick_action):
		should_pick = true

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return;
	
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if should_pick:
		should_pick = false
		var pickables: Array[MdsPickTarget3D] = []
		pickables.assign(pickable_items.values())
		for pick_target in pickables:
			var item: MdsItem3D = pick_target.parent
			item.picked.emit()
			picked.emit(item)

func _on_area_entered(area: Area3D) -> void:
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if area is MdsPickTarget3D:
		var key = area.parent.get_path().get_concatenated_names()
		pickable_items[key] = area

func _on_area_exited(area: Area3D) -> void:
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		return
	
	if area is MdsPickTarget3D:
		var key = area.parent.get_path().get_concatenated_names()
		if pickable_items.has(key):
			pickable_items.erase(key)
