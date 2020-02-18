
json.array! @api_users do |api_user|
  json.partial! 'api_user', api_user: api_user
end

json.array! @wishes do |wish|
  json.partial! 'wish', wish: wish
end

json.array! @experiences do |experience|
  json.partial! 'experience', experience: experience
end
