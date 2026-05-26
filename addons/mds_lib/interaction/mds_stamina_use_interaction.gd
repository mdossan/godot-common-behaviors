class_name MdsStaminaUseInteraction
extends MdsAbstractInteraction

@export var amount: float = 10.0
@export var interaction_label: String = "Use Stamina"

func get_interaction_label() -> String:
	return interaction_label

func execute_interaction(actor: Node):
	if !actor.has_meta("mds_stamina_logic"):
		push_error("Actor %s does not have a MdsStaminaLogic reference" % actor)
		return;
	
	var stamina_node: MdsStaminaLogic = actor.get_meta("mds_stamina_logic")
	stamina_node.consume_stamina(amount)
