@tool
class_name MdsStaminaBehavior extends Node

#region Exported Vars
@export var parent: Node:
	set(new_value):
		parent = new_value
		update_configuration_warnings()
@export var stamina_max_quantity: float = 100.0
@export var stamina_refill_per_second: float = 5.0
#endregion

#region Private vars
var stamina_quantity: float
#endregion

#region Signals
signal stamina_consumed(remaining_stamina: float)
signal stamina_refilled(current_stamina: float)
signal not_enough_stamina()
#endregion

#region Godot's Lifecycle
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	stamina_quantity = stamina_max_quantity
	parent.set_meta("mds_stamina_logic", self)
#endregion

#region Business Logic
func consume_stamina(quantity: float):
	if stamina_quantity >= quantity:
		stamina_quantity -= quantity
		stamina_consumed.emit(stamina_quantity)
	else:
		not_enough_stamina.emit()

func refill_stamina_per_second():
	if stamina_quantity >= stamina_max_quantity:
		return
	
	stamina_quantity = min(stamina_quantity + stamina_refill_per_second, stamina_max_quantity)
	stamina_refilled.emit(stamina_quantity)
#endregion

#region Configuration Warning
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	if parent == null:
		warnings.push_back("'Parent' should be defined")
	return warnings
#endregion
