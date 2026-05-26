class_name LooseLifeItemUsage
extends MdsItemUsage

@export var damage: float = 10.0

func use(_item: Node3D, _inventory: MdsInventoryBehavior3D, parent: Node):
	if !parent.has_meta(MdsLifeBehavior.meta):
		push_error("Can't loose life if parent doesn't have MdsLifeBehavior")
		return
	var life_behavior: MdsLifeBehavior = parent.get_meta(MdsLifeBehavior.meta)
	life_behavior.take_damage(damage)
