extends Control
# all my variables, including the generators
# generaters include booleans to see if they are owned or not
var coin: float = 0
var Clicker_str : float = 10
var upgrade_cost : float = 10
var gen_cost: float= 1000
var gen_owned: bool = false
var coins_per_sec : float = 0
var gen2_owned : bool = false
var gen2_cost :float = 10000
var gen3_owned: bool = false
var gen3_cost : float = 1000000

#Labels for current amount of coins and how much the upgrade costs
@onready var Coin_Label : Label = $Coin_Label
@onready var Upgrade_Label : Label = $Upgrade_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setting initial coin to 0
	coin = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# uses the coins_per_sec var to generate a certain amount of coins for every frame
	coin += coins_per_sec * delta
	#live counters for the ammount of coins and what the current upgrade costs
	Coin_Label.text ='Coins:' + str(int(coin))
	Upgrade_Label.text = 'cost: ' + str(int(upgrade_cost))
# Reciver function for clicker button
func _on_clicker_button_pressed() -> void:
# Whenever clicker is clicked, adds clicker strength
	coin +=Clicker_str
	print(coin)


func _on_upgrade_button_pressed() -> void:
	print('Upgrade')
	if coin >= upgrade_cost:
		coin -= upgrade_cost
		Clicker_str *= 3
		upgrade_cost *= 10
	else:
		print ('not enough coins')
	# when the upgrade button is pressed, it checks to see if you have enough coins
	# if you have enough, it *3 the clicker strength while making the next upgrade 10 times more expensive

# all three generators follow the same principles, after connecting a button signal to game manager,
# it checks to see if the button is pressed, then it sees if the generator is already owned if so it returns
# if it is not purchased yet, it sees if you have enough coins, if you do it adds to the coins per secc then takes away the amount it costs
func _on_gen_1_button_pressed() -> void:
	if gen_owned == true:
		return
	if coin >= gen_cost:
		coin -= gen_cost
		gen_owned = true
		coins_per_sec+= 50
		Coin_Label.text ='Coins:' + str(coin)
		print('gen purchased')
	else:
		print('not enough coins')

func _on_gen_2_button_pressed() -> void:
	if gen2_owned == true:
		return
	if coin >= gen2_cost:
		coin -= gen2_cost
		gen2_owned = true
		coins_per_sec+= 5000
		Coin_Label.text ='Coins:' + str(coin)
		print('gen purchased')
	else:
		print('not enough coins')


func _on_gen_3_button_pressed() -> void:
	if gen3_owned == true:
		return
	if coin >= gen3_cost:
		coin -= gen3_cost
		gen3_owned = true
		coins_per_sec+= 1000000
		Coin_Label.text ='Coins:' + str(coin)
		print('gen purchased')
	else:
		print('not enough coins')
		
		
# Everything below was an attempt at something I couldn't figure out\
# I couldn't find a signal to connect the audiostreamplayer to the button
#I also couldn't figure out how to make the coin the button
func _on_button_pressed():
	$AudioStreamPlayer.play()
func on_pressed():

	var c = coin_scene.instantiate() # Create the coin, and store a temp reference c
	add_child(c) # Add it to the tree so it shows up
	c.global_position = get_global_mouse_position() # Set the position to the cursor
@onready var coin_scene: PackedScene = load("res://Scenes/coin.tscn")
@export var game_manager: Node 
