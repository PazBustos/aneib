json.array!(@photos) do |photo|
  json.extract! photo, :id, :user_id, :tittle, :description, :picture, :date
  json.url photo_url(photo, format: :json)
end
