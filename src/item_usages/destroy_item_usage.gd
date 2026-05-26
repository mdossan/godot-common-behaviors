class_name DestroyItemUsage
extends MdsItemUsage

func use(node: Node, inventory: MdsInventoryBehavior3D, parent: Node3D):
	node.queue_free()
