extends Node2D


export (Vector2) var tree_position

func _ready():
	randomize()
	rotation = randf() * 2
	# if tree_position != null:
	# 	$Line2D.points[1] = tree_position
