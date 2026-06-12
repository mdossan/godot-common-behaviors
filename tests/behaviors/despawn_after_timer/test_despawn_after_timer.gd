extends MdsTestScene

func test():
	%MdsDespawnAfterTimerBehavior.despawn()
	await %MdsDespawnAfterTimerBehavior.despawned
	await %MdsDespawnAfterTimerBehavior.tree_exited
	assert_eq(get_child_count(), 0, "Child scene should be removed")
