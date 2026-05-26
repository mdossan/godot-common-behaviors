class_name CanMoveThePlayerDownSolo extends MdsTestScene

func _ready() -> void:
	test_label = "Can move the player down - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("down", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	assert(%Player.position.z > 0, "Player.position.z should be positive")
	await end_of_physics_frame
	
	success.emit(self)
	end_test()
