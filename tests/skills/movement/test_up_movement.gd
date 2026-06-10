extends MdsTestScene

func test():
	await input_press("up")
	await wait_physics_frame()

	if %CharacterBody3D.position.z < 0:
		succeed("CharacterBody3D has moved forward!")
	else:
		fail("CharacterBody3D has not moved forward!")
	
