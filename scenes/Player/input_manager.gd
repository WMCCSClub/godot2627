extends Node

@onready var network_ui: Panel = $"../CanvasLayer".find_child("MultiplayerUI")


func _unhandled_input(event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	#handle mouse input
	if event is InputEventMouseMotion:
		if not (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED): return	
		camera.process_mouse_delta(event)

	# handle press escape to free mouse
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	elif event.is_action_pressed("LMB") && Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	elif event.is_action_pressed("Network"):
		network_ui.visible = !network_ui.visible
	else:
		return
	
	# mark this input event as handled, even if _unhandled_input() was decleared in another script, it wont process this again
	get_viewport().set_input_as_handled()

@onready var camera = $"../Camera3D"
