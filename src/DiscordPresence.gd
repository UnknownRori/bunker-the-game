extends Node

func _ready():
	DiscordRPC.app_id = 1241329403137490975 # Application ID
	DiscordRPC.details = ""
	DiscordRPC.state = ""
	DiscordRPC.large_image = "icon" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Bunker the Game"
	DiscordRPC.small_image = "" # Image key from "Art Assets"
	DiscordRPC.small_image_text = ""

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!

func set_detail(detail):
	DiscordRPC.details = detail
	DiscordRPC.refresh()
