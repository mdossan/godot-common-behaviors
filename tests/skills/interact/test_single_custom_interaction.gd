extends MdsTestScene

func test():
	await input_press("interact")
	await %MdsInteractionCustom.interacting
	assert_is_valid(true, "Interaction was recorded")
