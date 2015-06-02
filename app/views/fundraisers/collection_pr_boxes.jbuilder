json.array! @collection_pr_boxes do |pr_box|
  json.(pr_box, :id, :headline, :story, :flag, :url)
end