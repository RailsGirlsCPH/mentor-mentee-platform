
json.array! @api_users do |api_user|
  json.partial! 'api_user', api_user: api_user
end

