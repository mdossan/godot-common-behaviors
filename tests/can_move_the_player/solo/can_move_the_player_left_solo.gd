class_name CanMoveThePlayerLeftSolo extends MdsTestScene

func _ready() -> void:
	test_label = "Can move the player left - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("left", true)
	await end_of_physics_frame
	
	assert(%Player.position.x < 0, "Player.position.x should be negative")
	success.emit(self)
	end_test()
