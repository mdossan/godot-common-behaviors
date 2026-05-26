class_name MdsInteractTarget3D extends Area3D

@export var parent: Node3D
@export var shape: Shape3D
@export var disabled: bool = false

var interactions: Array[MdsAbstractInteraction] = []
var current_actor: Node

func _ready():
	if shape != null:
		%Shape.shape = shape
	
	# Get interactions passed as children
	var children = get_children()
	interactions.assign(children.filter(func(e):
		return is_instance_valid(e) && e is MdsAbstractInteraction
	))
	
	# Build menu to choose interactions
	# Will be used when multiple interactions are possibles
	for interaction in interactions:
		var button: Button = Button.new()
		button.text = interaction.interaction_label
		button.button_down.connect(func ():
			interaction.execute_interaction(current_actor)
			%InteractMenu.visible = false
		)
		%PossibleInteractions.add_child(button)
	%InteractMenu.visible = false

func interact(actor: Node):
	if disabled:
		return

	if interactions.is_empty():
		push_warning("No interaction")
		return

	if interactions.size() == 1:
		print("before_interact")
		interactions.get(0).execute_interaction(actor)
		%InteractMenu.visible = false
		return
	
	current_actor = actor
	%InteractMenu.visible = true
