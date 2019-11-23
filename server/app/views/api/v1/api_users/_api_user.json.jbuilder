

json.call(api_user, :id, :mentor, :mentee)

json.wishes api_user.wishes do |wish|
  json.call(wish, :id, :goal, :available_online, :available_offline)
end
