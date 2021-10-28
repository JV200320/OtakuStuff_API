json.posts do
  json.array! (@posts) do |post|
    json.anime_id post.anime_id
    json.content post.content
    json.created_at post.created_at
    json.updated_at post.updated_at
    json.id post.id
    json.kind post.kind
    json.user_id post.user_id
    json.user_nickname post.user_nickname
    json.user_image_url post.user_image_url
    json.likes post.anime_likes, :id, :anime_post_id, :user_id
    json.replies post.replies.count
  end
end
