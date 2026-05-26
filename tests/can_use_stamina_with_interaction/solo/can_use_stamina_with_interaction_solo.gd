class_name CanUseStaminaWithInteractionSolo
extends MdsTestScene

func _ready() -> void:
	test_label = "Can use stamina on interaction - Solo"
	test_case()

func test_case():
	await start_of_physics_frame
	send_input("interact", true)
	await end_of_physics_frame
	
	assert(%MdsStaminaLogic.stamina_quantity < 100, "Stamina should be consumed")
	
	success.emit(self)
	end_test()
