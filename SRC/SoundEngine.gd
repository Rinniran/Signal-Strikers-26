extends Node

@onready var sc = [AudioStreamPlayer.new(),AudioStreamPlayer.new(),AudioStreamPlayer.new(),
	AudioStreamPlayer.new(),AudioStreamPlayer.new(),AudioStreamPlayer.new(),AudioStreamPlayer.new(),
	AudioStreamPlayer.new(),AudioStreamPlayer.new(),AudioStreamPlayer.new(),AudioStreamPlayer.new(),
	AudioStreamPlayer.new()] # 12 sound channels
	
var channel = []

func _ready() -> void:
	for channels in sc:
		add_child(channels)
		channel.append(channels)


func playsound(soundchannel = 0, soundstream = AudioStream, vol = 0):
	channel[soundchannel].stop()
	channel[soundchannel].stream = soundstream
	channel[soundchannel].volume_db = vol
	channel[soundchannel].play()

func playsoundstring(soundchannel = 0, soundstream = "Audiostream", vol = 0):
	channel[soundchannel].stop()
	channel[soundchannel].stream = load(soundstream)
	channel[soundchannel].volume_db = vol
	channel[soundchannel].play()
