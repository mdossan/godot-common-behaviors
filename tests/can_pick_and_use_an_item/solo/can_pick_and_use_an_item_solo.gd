class_name CanPickAndUseAnItemSolo
extends MdsTestScene

func _ready() -> void:
	test_label = "Can pick and use an item - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("pick", true)
	await end_of_physics_frame
	
	assert(%MdsInventoryBehavior3D.get_child_count() == 1, "One item should be in inventory")
	
	await start_of_physics_frame
	send_input("use", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	assert(%MdsInventoryBehavior3D.get_child_count() == 0, "Item should no longer be in inventory")
	await end_of_physics_frame
	
	success.emit(self)
	end_test()
