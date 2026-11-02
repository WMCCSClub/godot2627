extends Node

var port := 5000
var ip_address := "LAN_Host"
var _max_player := 32

## become a client and join a server
func create_clinet(server_addr:String, _port:=port):
	port = _port
	ip_address = server_addr

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
