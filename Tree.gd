extends Node2D

export (int, 0, 100) var branch_amount = 3

onready var branch_head = preload("res://BranchHead.tscn")
onready var branch_line = preload("res://BranchLine.tscn")

# Max spread range of branches

export (Vector2) var max_branch_spread = Vector2(35, 35)

# The scale range of the main leaves/crown
export (Vector2) var self_scale_range = Vector2(2.5, 4)

# The scale range of the branch heads
export (Vector2) var branch_head_scale_range = Vector2(0.75, 2)

# The color range of the main leaves/crown
export (Vector2) var self_red_color_range = Vector2(200, 255)
export (Vector2) var self_blue_color_range = Vector2(200, 255)
export (Vector2) var self_green_color_range = Vector2(200, 255)

# The color range of the branch heads
export (Vector2) var branch_head_red_color_range = Vector2(200, 255)
export (Vector2) var branch_head_blue_color_range = Vector2(200, 255)
export (Vector2) var branch_head_green_color_range = Vector2(200, 255)

# The width of the line/limb
export (Vector2) var branch_line_width_range = Vector2(8, 12)

# The color range of the line/limb
export (Vector2) var branch_line_red_color_range = Vector2(60, 90)
export (Vector2) var branch_line_blue_color_range = Vector2(20, 25)
export (Vector2) var branch_line_green_color_range = Vector2(5, 15)

func _ready():
	randomize()
	

	# Variation in the main leaves, also known as the Crown of the tree 
	rotation = randf() * 2
	self.z_index = branch_amount + 1
	var self_scale = rand_range(self_scale_range.x, self_scale_range.y)
	$Sprite.scale = Vector2(self_scale, self_scale)
	var self_color = Color(rand_range(self_red_color_range.x, self_red_color_range.y)/255, rand_range(self_green_color_range.x, self_green_color_range.y)/255, rand_range(self_blue_color_range.x, self_blue_color_range.y)/255, 1)
	$Sprite.modulate = self_color

	# This is repeated for each branch
	for i in branch_amount:
		
		var branch_head_instance = branch_head.instance()
		var branch_position = Vector2()
		# A branch head's position is randomized, the max_branch_spread is the reference value, the branch's position will be in that range relative to the trunk
		branch_position.x = rand_range(global_position.x + max_branch_spread.x, global_position.x - max_branch_spread.x)
		branch_position.y = rand_range(global_position.y + max_branch_spread.y, global_position.y - max_branch_spread.y)
		
		branch_head_instance.global_position = branch_position
		branch_head_instance.tree_position = branch_head_instance.global_position - self.global_position 
		branch_head_instance.z_index = i


		# A color is randomized between adjustable values, for variation
		var branch_head_color = Color(rand_range(branch_head_red_color_range.x, branch_head_red_color_range.y)/255, rand_range(branch_head_green_color_range.x, branch_head_green_color_range.y)/255, rand_range(branch_head_blue_color_range.x, branch_head_blue_color_range.y)/255, 1)
		branch_head_instance.modulate = branch_head_color
		# A scale is randomized between adjustable values, for variation
		var branch_head_scale = rand_range(branch_head_scale_range.x, branch_head_scale_range.y)
		branch_head_instance.scale = Vector2(branch_head_scale, branch_head_scale)
		add_child(branch_head_instance)
		
		# For the branch head's connection to the tree trunk, also known as limbs of the tree.

		var branch_line_instance = branch_line.instance()

		# The line gets connected to the trunk

		branch_line_instance.points[1] = branch_head_instance.position
		branch_line_instance.z_index = i - 2
		branch_line_instance.width = rand_range(branch_line_width_range.x, branch_line_width_range.y)
		branch_line_instance.default_color = Color(rand_range(branch_line_red_color_range.x, branch_line_red_color_range.y)/255, rand_range(branch_line_green_color_range.x, branch_line_green_color_range.y)/255, rand_range(branch_line_blue_color_range.x, branch_line_blue_color_range.y)/255, 1)
		add_child(branch_line_instance)
		
		pass
	

