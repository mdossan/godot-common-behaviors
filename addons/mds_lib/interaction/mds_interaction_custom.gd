class_name MdsInteractCustom
extends MdsAbstractInteraction

signal interacting(actor: Node)

@export var interaction_label: String = "Interact"

func get_interaction_label() -> String:
	return interaction_label

func execute_interaction(actor: Node):
	print("execute_interaction")
	if actor.get_multiplayer_authority() != get_multiplayer_authority():
		remote_interact.rpc(actor.get_path())
	else:
		interacting.emit(actor)

@rpc("any_peer", "call_remote")
func remote_interact(actor_path: String):
	print("remote_interact received")
	var calling_actor = get_tree().root.get_node(actor_path)
	interacting.emit(calling_actor)
