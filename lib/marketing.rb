module Marketing
  
  def self.check_images_for_post(post_id)
    #TODO sms here, after we mark it as active
    
    post = Post.find(post_id)

    link = 'http://localhost:8000/api/predict?token=24apa2001&cloudinary_url='

    count = 0

    post.assets.each do |asset|
      asset_link = link + asset.image.url.split('http://res.cloudinary.com/')[1]

      h = HTTParty.post(asset_link)
      binding.pry
    end
  end
end