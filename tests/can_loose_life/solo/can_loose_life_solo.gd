class_name CanLooseLifeSolo
extends MdsTestScene

func _ready() -> void:
	test_label = "Can loose life - Solo"
	test_case()

# TODO: Check how closure works in Godot,
# If this line is in test_case, the test fail
var damage_taken_count = 0
var dead_call_count = 0

func test_case():
	%MdsLifeBehavior.damage_taken.connect(func(_a, _b): damage_taken_count += 1)
	%MdsLifeBehavior.dead.connect(func(): dead_call_count += 1)
	
	await start_of_physics_frame
	send_input("pick", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	send_input("use", true)
	await end_of_physics_frame
	
	await start_of_physics_frame
	assert(damage_taken_count == 1, "Signal `damage_taken` should be called once")
	assert(%MdsLifeBehavior.life == 90, "Life should be 90")
	await end_of_physics_frame
	
	# TODO: Test Heal behavior
	
	for i in range(0, 9):
		await start_of_physics_frame
		send_input("use", true)
		await end_of_physics_frame
	
	await start_of_physics_frame
	assert(damage_taken_count == 9, "Signal `damage_taken` should be called nine times")
	assert(dead_call_count == 1, "Signal `dead` should be called once")
	assert(%MdsLifeBehavior.life == 0, "Life should be 0")
	await end_of_physics_frame
	
	success.emit(self)
	end_test()
