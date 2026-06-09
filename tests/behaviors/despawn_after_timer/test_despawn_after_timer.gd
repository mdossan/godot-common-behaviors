extends MdsTestScene

func test():
	%MdsDespawnAfterTimerBehavior.despawn()
	await %MdsDespawnAfterTimerBehavior.despawned
	if is_instance_valid(%Subject):
		succeed("Subject has been removed")
	else:
		fail("Subject is still valid")
