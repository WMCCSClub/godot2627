## this file is configure autoloaded, not useless
## this file contain information and function related to network
## both client and server scripts


extends Node

@onready var multiplayer_spawner: MultiplayerSpawner = get_tree().current_scene.find_child("MultiplayerSpawner")

var network_state := NetworkState.SINGLE_PLAYER


var port := 5000
var ip_address := "LAN_Host"
var _max_player := 32
var _current_network_peer: ENetMultiplayerPeer

enum NetworkState{
	SINGLE_PLAYER,
	CLIENT,
	SERVER
}


## become a client and join a server
func create_clinet(server_addr:String, _port:=port) -> bool:
	port = _port
	ip_address = server_addr
	_current_network_peer = ENetMultiplayerPeer.new()
	
	 #delete all child so multiplayer spawner can stream all the content from server to there
	if !multiplayer_spawner: return false
	var spawn_dir = multiplayer_spawner.get_node(multiplayer_spawner.spawn_path)
	if !spawn_dir: return false
	for child in spawn_dir.get_children():
		child.queue_free()
	
	_current_network_peer.create_client(server_addr, _port)
	multiplayer.multiplayer_peer = _current_network_peer
	return true


## become a server and allow other people to join
func create_server(max_player, _port:=port):
	port = _port
	max_player = max_player
	_current_network_peer = ENetMultiplayerPeer.new()
	_current_network_peer.create_server(_port, max_player)
	multiplayer.multiplayer_peer = _current_network_peer
	

## end network
func terminate_network() -> void:
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	_current_network_peer = null
	network_state = NetworkState.SINGLE_PLAYER

## check if the port is within 1024-65535, the rest are reserved ports
func port_valid_check(_port:int) -> bool:
	if _port >= 1024 and _port <= 65535:
		return true
	return false


func find_lan_IPv4() -> String:
	var all_ip := IP.get_local_addresses()
	for ip in all_ip:
		if ip.begins_with("10.") or ip.begins_with("192.168."):
			return ip
	return ""
