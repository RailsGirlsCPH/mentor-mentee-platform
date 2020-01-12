json.array! @wishes do |wish|
  json.partial! 'wish', wish: wish
end

