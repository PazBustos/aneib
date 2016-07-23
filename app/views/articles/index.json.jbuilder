json.array!(@articles) do |article|
  json.extract! article, :id, :user_id, :topic_id, :title, :description
  json.url article_url(article, format: :json)
end
