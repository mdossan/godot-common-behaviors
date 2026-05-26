class_name CanMoveThePlayerUpSolo extends MdsTestScene

func _ready() -> void:
	test_label = "Can move the player up - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("up", true)
	await end_of_physics_frame
	
	assert(%Player.position.z < 0, "Player.position.z should be negative")
	success.emit(self)
	end_test()
