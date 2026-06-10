extends MdsTestScene

func test():
	await input_press("interact")
	await %MdsInteractionCustom.interacting
	succeed("Interaction was recorded")
