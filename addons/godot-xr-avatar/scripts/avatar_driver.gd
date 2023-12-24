class_name XRAvatarDriver
extends Node


@export var avatar : XRAvatar : set = _set_avatar


var _body : XRToolsPlayerBody

var _camera : XRCamera3D

var _left_controller : XRController3D

var _right_controller : XRController3D

var _current_avatar : XRAvatar


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set physics priority
	process_physics_priority = -100

	# Get the XR nodes
	_body = XRToolsPlayerBody.find_instance(self)
	_camera = XRHelpers.get_xr_camera(self)
	_left_controller = XRHelpers.get_left_controller(self)
	_right_controller = XRHelpers.get_right_controller(self)

	# Update the avatar
	_update_avatar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not _current_avatar:
		return

	# Update the current avatar
	_current_avatar.global_transform = _body.global_transform
	_current_avatar.head_target.global_transform = _camera.global_transform
	_current_avatar.left_hand_target.global_transform = _left_controller.global_transform
	_current_avatar.right_hand_target.global_transform = _right_controller.global_transform


func _set_avatar(p_avatar : XRAvatar) -> void:
	# Save the avatar and update if inside tree
	avatar = p_avatar
	if is_inside_tree():
		_update_avatar()


func _update_avatar() -> void:
	# Stop wearing old avatar
	if _current_avatar:
		_current_avatar.worn = false

	# Wear the new avatar
	_current_avatar = avatar
	if _current_avatar:
		_current_avatar.worn = true
