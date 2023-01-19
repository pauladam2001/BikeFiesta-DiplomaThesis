module Marketing
  
  def self.check_images_for_post(post_id)
    #TODO sms here, after we mark it as active
    
    post = Post.find(post_id)

    link = 'http://localhost:8000/api/predict?token=24apa2001'

    post.assets.each do |asset|
      #TODO

      # bodyCall = { "file": asset.image }

      # h = HTTParty.post(link, body: bodyCall)
      # binding.pry
    end
  end
end