extends MdsTestScene

func test():
	await get_tree().physics_frame
	var ev = InputEventAction.new()
	ev.action = "interact"
	ev.pressed = true
	Input.parse_input_event(ev)
	await %MdsInteractionCustom.interacting
	succeed("Interaction was recorded")
