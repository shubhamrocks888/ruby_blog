json.extract! poem, :id, :title, :body, :created_at, :updated_at
json.url poem_url(poem, format: :json)
