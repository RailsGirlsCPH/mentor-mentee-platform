module RequestSpecHelper
  # Parse JSON reponse to ruby hash
  def json
    JSON.parse(response.body)
  end
end
