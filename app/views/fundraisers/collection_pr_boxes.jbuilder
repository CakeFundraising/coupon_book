json.array! @collection_pr_boxes do |pr_box|
  json.(pr_box, :id, :title, :description, :flag, :url, :disabled)
  json.itemType 'PRBOX'
  json.sponsorName pr_box.sponsor_name
end