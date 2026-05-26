# mdossan's behaviors

Library to improve dev time by defining commons behaviors in some games

# Summary
	- Definitions
	- Skills
	- Behaviors
	- Item
	- Interaction

# Definitions

Skill: Action that can be triggered without any kind of item/condition
Behaviors: Passive logic running alongside of the player skill
MdsItem: Scene that can be stored in an inventory
/!\ Need to be done fast
MdsItemUsage: Action faite grace a un MdsItem selectionne dans le MdsInventory
Interaction: Action made by the player on a world object
Actor: Entity making an action on a scene
Target: Scene receiving an action from a actor

# Skills
	- Movement
	- Jump
	- Dash
	- PickItem (See Item)
	- DropItem (See Item)
	- Spell
	- Interact (See interaction)

# Behaviors
	- Health
	- Stamina
	- Oxygen
	- Energy
	- SpawnGoblins
	- TiresUsage

# MdsItem
	- Potion
	- Piece
	- Arme

# Interactions
	- Lever
	- Healing fontain
	- Trucnk

# Movement
MdsMovementLogic => Skill
MdsJump => Skill
MdsGravity

# Life
MdsLifeLogic
MdsAttackAction, MdsAttackTarget

# Inventory

MdsInventoryLogic

# Common
MdsDespawntimerLogic...
