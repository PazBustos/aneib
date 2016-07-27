json.extract! interest_link, :id, :name, :url, :description, :created_at, :updated_at
json.url interest_link_url(interest_link, format: :json)