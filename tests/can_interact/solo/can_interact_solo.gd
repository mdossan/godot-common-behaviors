class_name CanInteractSolo
extends MdsTestScene

func _ready() -> void:
	test_label = "Can interact - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("interact", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	assert(%InteractableCube.rotation.y > 0, "Cube should be rotated")
	await end_of_physics_frame
	
	success.emit(self)
	end_test()
