extends MdsTestScene

func test():
	assert_eq(%MdsLifeBehavior.life, 100, "Life should be 100")
	%MdsLifeBehavior.take_damage(10)
	assert_eq(%MdsLifeBehavior.life, 90, "Life should be 90")
	%MdsLifeBehavior.heal(5)
	assert_eq(%MdsLifeBehavior.life, 95, "Life should be 95")
