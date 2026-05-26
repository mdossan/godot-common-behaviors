extends RigidBody3D

@export var throw_force: int = 100

func throw(item: MdsItem3D, inventory: MdsInventoryBehavior3D):
	inventory.drop_item(item)
	freeze = false
	sleeping = false
	apply_impulse(Vector3.FORWARD * throw_force)
