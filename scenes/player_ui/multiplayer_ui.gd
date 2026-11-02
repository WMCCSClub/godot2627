##this script controls the entire network ui, might need to sub-devide if it gets too bloated=
extends Panel

@onready var host_port_input: LineEdit = $ServerOptions/VBoxContainer/PortInput/LineEdit
@onready var join_port_input: LineEdit = $ClientOptions/VBoxContainer/PortInput/LineEdit
@onready var max_player_input: SpinBox = $ServerOptions/VBoxContainer/MaxPlayerInput/SpinBox


func _ready() -> void:
	visible = false
	$ServerOrClient.visible = true
	$ServerOptions.visible = false
	$ClientOptions.visible = false
	$AfterServer.visible = false
	host_port_input.text = str(NetworkHandler.port)
	join_port_input.text = str(NetworkHandler.port)


## choose client or server

func _on_server_pressed() -> void:
	$ServerOrClient.visible = false
	$ServerOptions.visible = true
func _on_client_pressed() -> void:
	$ServerOrClient.visible = false
	$ClientOptions.visible = true

func _on_create_server_pressed() -> void:
	# check if port is valid, if not remind the user
	var port_int = _check_port(host_port_input)
	if not port_int: return
	# to creating server in network handler
	NetworkHandler.create_server(max_player_input.value, port_int)
	$ServerOptions.visible = false
	$AfterServer.visible = true

func _on_create_client_pressed() -> void:
	# check if port is valid, if not remind the user
	var port_int = _check_port(join_port_input)
	if not port_int: return
	# to creating client in network handler
	NetworkHandler.create_clinet($ClientOptions/VBoxContainer/AddrInput/LineEdit.text, port_int)
	$ClientOptions.visible = false
	$AfterServer.visible = true

## check if port is valid, if is, return port in int, if not return 0
func _check_port(port_input: LineEdit) -> int:
	var port_int = int(port_input.text)
	# check if port is valid, if not remind the user
	if not NetworkHandler.port_valid_check(port_int):
		port_input.text = ""
		port_input.placeholder_text = "invalid, use 1024 to 65535"
		return 0
	else:
		return port_int
