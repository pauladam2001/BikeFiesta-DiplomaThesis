module Marketing
  
  def self.check_images_for_post(post_id)
    post = Post.find(post_id)
    link = 'http://localhost:8000/api/predict?token=24apa2001&cloudinary_url='
    is_bicycle = false

    post.assets.each do |asset|
      asset_link = link + asset.image.url.split('http://res.cloudinary.com/')[1]

      h = HTTParty.post(asset_link)
      
      h.each do |response|
        if (response["class"].include?("bike") || response["class"].include?("bicycle") || response["class"].include?("cycle")) || response["confidence"] >= 50.0
          is_bicycle = true
          break
        end
      end

      if is_bicycle
        break
      end
    end

    if is_bicycle
      post.is_active = 1
      #TODO asyncSendSMS
    else
      post.is_active = -1
    end

    post.save(validate: false)
  end

  # Called hourly
  def self.check_posts_without_assets
    Post.find_each do |post|
      if post.assets.count < 0
        Post.destroy
      end
    end
  end
end