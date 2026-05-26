class_name CanPickSimpleItemSolo
extends MdsTestScene

func _ready() -> void:
	test_label = "Can pick simple item - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("pick", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	assert(%MdsInventoryLogic.get_child_count() == 1, "Item should be in inventory")
	assert(%WorldItems.get_child_count() == 0, "World items should be empty")
	await end_of_physics_frame
	
	success.emit(self)
	end_test()
