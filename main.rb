require 'yaml'
require 'lastfm'
require 'highline/import'
require 'json'
require 'pp'

settings = YAML.load_file('settings.yml')
connection_object = Lastfm.connect settings['api_key']

begin
  username = ask "Enter username: "
  response = connection_object.get_user_weekly_track_chart username
  json_data = JSON.parse(response)

  puts "Recent Tracks and play-count for #{username}"
  puts "-----------------------------------"

  json_data['weeklytrackchart']['track'].each do |track|
    puts "#{track['artist']['#text']} - #{track['name']} ::: #{track['playcount']} plays"
  end
end while agree "Would you like to view recent tracks for another user? "