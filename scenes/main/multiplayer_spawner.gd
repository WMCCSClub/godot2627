extends MultiplayerSpawner

@export var player_template: PackedScene

@onready var player_parent = get_node(spawn_path)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	spawn_player(1)

func spawn_player(id:int):
	if !multiplayer.is_server(): return
	
	var new_player: CharacterBody3D = player_template.instantiate()
	new_player.player_id = id
	new_player.name = str(id)
	player_parent.call_deferred("add_child", new_player)
	
	## give player network athority
	new_player.set_multiplayer_authority(id)
