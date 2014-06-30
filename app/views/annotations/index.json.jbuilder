json.array!(@annotations) do |annotation|
  json.extract! annotation, :id, :label, :priority, :prefer_user, :text_file, :image_files, :user_id, :finished, :skipped, :appropriate, :not_appropriate
  json.url annotation_url(annotation, format: :json)
end
