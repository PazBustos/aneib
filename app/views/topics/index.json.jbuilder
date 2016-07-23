json.array!(@topics) do |topic|
  json.extract! topic, :id, :user_id, :article_id, :title, :description
  json.url topic_url(topic, format: :json)
end
