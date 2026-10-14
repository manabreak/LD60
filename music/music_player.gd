extends Node

@export var stream_player: AudioStreamPlayer
@export var tracks: Array[MusicTrack]

var current: MusicTrack = null
var current_stream: AudioStream = null


func _ready() -> void:
	stream_player.finished.connect(self.on_finished)


func on_finished() -> void:
	current_stream = current.loop
	stream_player.stream = current_stream
	stream_player.play()


func play_track(name: StringName) -> void:
	var i = 0
	for track in tracks:
		if track.track_name == name:
			play_at(i)
			break
		i += 1


func play_at(index: int) -> void:
	if current != null:
		if tracks.find(current) == index:
			return
		stream_player.stop()
	
	current = tracks[index]
	if current.intro != null:
		current_stream = current.intro
	else:
		current_stream = current.loop
	
	stream_player.stream = current_stream
	stream_player.play()


func stop() -> void:
	stream_player.stop()
