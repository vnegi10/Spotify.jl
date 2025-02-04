## https://developer.spotify.com/documentation/web-api/reference/#/operations/get-information-about-the-users-current-playback

"""
    player_get_state(;additional_types::String="track", market::String="US")

**Summary**: Get information about the user’s current playback state, including track or episode, 
             progress, and active device.

# Optional keywords
- `additional_types::String` : "track" (default) or "episode"
- `market::String` : An ISO 3166-1 alpha-2 country code. If a country code is specified, 
                     only episodes that are available in that market will be returned. 
                     Default is set to "US".

# Example
```julia-repl
julia> Spotify.player_get_state()[1]
[ Info: We try the request without checking if current grant includes scope user-read-playback-state.
JSON3.Object{Base.CodeUnits{UInt8, String}, Vector{UInt64}} with 10 entries:
  :device                 => {…
  :shuffle_state          => false
  :repeat_state           => "off"
  :timestamp              => 1636493367689
  :context                => {…
  :progress_ms            => 66454
  :item                   => {…
  :currently_playing_type => "track"
  :actions                => {…
  :is_playing             => true
```
"""
function player_get_state(;additional_types::String="track", market::String="US")

    url = "me/player?additional_types=$additional_types&market=$market"

    return Spotify.spotify_request(url; scope = "user-read-playback-state")

end


## https://developer.spotify.com/documentation/web-api/reference/#/operations/get-a-users-available-devices

"""
    player_get_devices()

**Summary**: Get information about a user’s available devices.

# Example
```julia-repl
julia> Spotify.player_get_devices()[1]["devices"]
2-element JSON3.Array{JSON3.Object, Base.CodeUnits{UInt8, String}, SubArray{UInt64, 1, Vector{UInt64}, Tuple{UnitRange{Int64}}, true}}:
{
                   "id": "your_device_id",
            "is_active": false,
   "is_private_session": false,
        "is_restricted": false,
                 "name": "Web Player (Chrome)",
                 "type": "Computer",
       "volume_percent": 100
}
```
"""
function player_get_devices()

    return Spotify.spotify_request("me/player/devices"; scope = "user-read-playback-state")

end


## https://developer.spotify.com/documentation/web-api/reference/#/operations/get-the-users-currently-playing-track

"""
    player_get_current_track(;additional_types::String="track", market::String="US")

**Summary**: Get the object currently being played on the user's Spotify account.

# Optional keywords
- `additional_types::String` : "track" (default) or "episode"
- `market::String` : An ISO 3166-1 alpha-2 country code. If a country code is specified, 
                     only episodes that are available in that market will be returned. 
                     Default is set to "US".

# Example
```julia-repl
julia> Spotify.player_get_current_track()[1]
[ Info: We try the request without checking if current grant includes scope user-read-playback-state.
JSON3.Object{Base.CodeUnits{UInt8, String}, Vector{UInt64}} with 7 entries:
  :timestamp              => 1636491068506
  :context                => {…
  :progress_ms            => 5265
  :item                   => {…
  :currently_playing_type => "track"
  :actions                => {…
  :is_playing             => true
```
"""
function player_get_current_track(;additional_types::String="track", market::String="US")

    url = "me/player/currently-playing?additional_types=$additional_types&market=$market"

    return Spotify.spotify_request(url; scope = "user-read-playback-state")

end


## https://developer.spotify.com/documentation/web-api/reference/#/operations/get-recently-played

"""
    player_get_recent_tracks(;duration::Int64=1, limit::Int64=20)

**Summary**: Get current user's recently played tracks.

# Optional keywords
- `duration::Int64` : Number of days to look in the past, default is set to 1
- `limit::Int64` : Maximum number of items to return, default is set to 20

# Example
```julia-repl
julia> Spotify.player_get_recent_tracks()[1]
[ Info: We try the request without checking if current grant includes scope user-read-recently-played.
JSON3.Object{Base.CodeUnits{UInt8, String}, Vector{UInt64}} with 5 entries:
  :items   => JSON3.Object[{…
  :next    => "https://api.spotify.com/v1/me/player/recently-played?after=1636123644988&limit=20"
  :cursors => {…
  :limit   => 20
  :href    => "https://api.spotify.com/v1/me/player/recently-played?after=1636410050&limit=20"
```
"""
function player_get_recent_tracks(;duration::Int64=1, limit::Int64=20)

    # Subtract duration from current date and convert to Int64
    starting_date = Dates.datetime2unix(Dates.now() - Dates.Day(duration))
    after = round(Int64, starting_date)

    url = "me/player/recently-played?after=$after&limit=$limit"

    return Spotify.spotify_request(url; scope = "user-read-recently-played")

end







