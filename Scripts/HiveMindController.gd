extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



onready var tileset = $TileMap.tile_set

onready var FULL_TEXTURE = tileset.tile_get_texture(0)

onready var QUEEN_TEXTURE : AtlasTexture = AtlasTexture.new()
#onready var QUEEN_TEXTURE : Texture = tileset.tile_get_texture(3).get_data()
onready var TIER_1_TEXTURE : AtlasTexture = AtlasTexture.new()
onready var TIER_2_TEXTURE : AtlasTexture = AtlasTexture.new()
onready var TIER_3_TEXTURE : AtlasTexture = AtlasTexture.new()

onready var creature_textures = [TIER_1_TEXTURE, TIER_2_TEXTURE, TIER_3_TEXTURE, QUEEN_TEXTURE]


enum tier {TIER_1, TIER_2, TIER_3, TIER_4, QUEEN}

# Is an array of kinematic bodies that represent the creatures
# FIrst layer is the creature teir, then in each tier ae all the creature bodies for that teir
onready var creatures : Array = [ [], [], [], [] ]
var creature_types = []


onready var queen_body = $KinematicBody2D

var destination : Vector2 
export var queen_speed : float = 3


var orders = {}

func _physics_process(delta):
	
	var orders_to_delete = []
	for creature_body in orders.keys() :
		
		var destination = orders[creature_body]
		var diff = (destination - creature_body.global_position)
		
		if diff.length() <= queen_speed :
			creature_body.global_position = destination
			orders_to_delete.append(creature_body)
			
		else :
			var movement = queen_speed * diff.normalized()
			creature_body.global_position += movement
	
	for creature_body in orders_to_delete :
		orders.erase(creature_body)
		
	
func _draw():
	draw_texture(QUEEN_TEXTURE, queen_body.global_position )
	
	
	for creature_tier_num in len(creatures) :
		var creature_texture = creature_textures[creature_tier_num]
		
		for creature_body in creatures[creature_tier_num]:
			var creature_position = creature_body.global_position
			draw_texture(creature_texture, creature_position - Vector2(32,32))


func add_creature(creature_type, creature_body):
	creatures[creature_type].append(creature_body)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	QUEEN_TEXTURE.atlas = FULL_TEXTURE
	QUEEN_TEXTURE.region = tileset.tile_get_region(2)
	TIER_1_TEXTURE.atlas = FULL_TEXTURE
	TIER_1_TEXTURE.region = tileset.tile_get_region(3)
	TIER_2_TEXTURE.atlas = FULL_TEXTURE
	TIER_2_TEXTURE.region = tileset.tile_get_region(0)
	TIER_3_TEXTURE.atlas = FULL_TEXTURE
	TIER_3_TEXTURE.region = tileset.tile_get_region(1)
	
	add_creature(tier.TIER_3,$KinematicBody2D/CollisionShape2D2)
	
	add_creature(tier.TIER_1,$KinematicBody2D/CollisionShape2D3)
	
	add_creature(tier.TIER_2,$KinematicBody2D/CollisionShape2D4)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			pass
			#destination = event.position
	
			
func _process(delta):
	update()



func _on_Node2D_move_tier(tier, creature_ids, destination):
	
	var creatures_in_tier = creatures[tier]
	var all_bodies = $KinematicBody2D.get_children()
	for id in creature_ids :
		var creature_body = all_bodies[id]
		if  creature_body in creatures_in_tier :
			orders[creature_body] = destination
