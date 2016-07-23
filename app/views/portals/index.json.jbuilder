json.array!(@portals) do |portal|
  json.extract! portal, :id, :user_id, :title, :body, :priority, :section
  json.url portal_url(portal, format: :json)
end
