extends GutTest

var scene = preload("res://addons/mds_lib/behaviors/life/mds_life_behavior.tscn")

var root_node: Node
var behavior: MdsLifeBehavior

func before_each():
	behavior = scene.instantiate()
	root_node = Node.new()
	behavior.parent = root_node
	root_node.add_child(behavior)
	
	add_child_autofree(root_node)
	watch_signals(behavior)

func test_default_values():
	assert_eq(behavior.life, 100.0, "Default value should be 100")
	
func test_take_damage():
	behavior.take_damage(20.0)
	
	assert_signal_emitted_with_parameters(behavior.damage_taken, [20.0, 80.0])
	assert_eq(behavior.life, 80.0, "life should be 80")

func test_life_behavior():
	behavior.life = 50.0
	behavior.heal(10.0)
	
	assert_signal_emitted_with_parameters(behavior.heal_taken, [10.0, 60.0])
	assert_eq(behavior.life, 60.0, "life should be 60")

func test_death_signal():
	behavior.take_damage(1000.0)
	
	assert_signal_not_emitted(behavior.damage_taken)
	assert_signal_emitted_with_parameters(behavior.dead, [])
	assert_eq(behavior.life, 0.0, "life should be 0")
	
