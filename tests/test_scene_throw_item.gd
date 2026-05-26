extends MdsTestScene

func _ready() -> void:
	test_label = "Test Throw Item"
	test_case()

func test_case():
	# Frame 1
	await start_of_physics_frame
	var action = InputEventAction.new()
	action.action = "use"
	action.pressed = true
	Input.parse_input_event(action)
	Input.flush_buffered_events() # Be sure the simulated event is treated
	await end_of_physics_frame # Wait for _physics_process of all children to update

	# Assert !
	if %ThrowableRock.position == Vector3.ZERO:
		fail.emit(self)
	if %World.get_child_count() == 0:
		fail.emit(self)
	success.emit(self)
	end_test()
