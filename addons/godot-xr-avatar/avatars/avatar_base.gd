@tool
class_name XRAvatarBase
extends Node3D


@export var head_target : Marker3D

@export var left_hand_target : Marker3D

@export var right_hand_target : Marker3D


func set_visibility_for(p_peer : int, p_visible : bool) -> void:
	$MultiplayerSynchronizer.set_visibility_for(p_peer, p_visible)
