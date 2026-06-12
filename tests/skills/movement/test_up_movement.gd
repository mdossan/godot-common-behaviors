extends MdsTestScene

func test():
	await input_press("up")
	await wait_physics_frame()
	assert_lt(%CharacterBody3D.position.z, 0, "CharacterBody3D has not moved forward!")
