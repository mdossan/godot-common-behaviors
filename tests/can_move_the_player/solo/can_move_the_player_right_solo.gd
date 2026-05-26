class_name CanMoveThePlayerRightSolo extends MdsTestScene

func _ready() -> void:
	test_label = "Can move the player right - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("right", true)
	await end_of_physics_frame
	
	assert(%Player.position.x > 0, "Player.position.x should be positive")
	success.emit(self)
	end_test()
