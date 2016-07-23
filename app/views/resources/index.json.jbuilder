json.array!(@resources) do |resource|
  json.extract! resource, :id, :name, :description, :category, :date
  json.url resource_url(resource, format: :json)
end
