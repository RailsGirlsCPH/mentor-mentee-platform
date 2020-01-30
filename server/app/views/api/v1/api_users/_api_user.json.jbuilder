

json.call(api_user, :id, :username, :first_name, :last_name, :email, :mentor, :mentee)

json.wishes api_user.wishes do |wish|
  json.call(wish, :id, :goal, :available_online, :available_offline, :language, :interval)
end

json.experiences api_user.experiences do |experience|
    json.call(experience, :id, :qualification, :available_online, :available_offline, :language, :interval)
end

