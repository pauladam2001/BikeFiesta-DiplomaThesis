module Marketing
  
  # Called every time a post is created (async)
  # This function checks if there is a bike photo in the images associated with a post and after that it makes the post
  # active and sends an SMS for the followers of the user
  def self.check_images_for_post(post_id)
    post = Post.find(post_id)
    link = 'http://localhost:8000/api/predict?token=24apa2001&cloudinary_url='
    is_bicycle = false

    post.assets.each do |asset|
      asset_link = link + asset.image.url.split('http://res.cloudinary.com/')[1]

      h = HTTParty.post(asset_link)
      
      h.each do |response|
        if (response["class"].include?("bike") || response["class"].include?("bicycle") || response["class"].include?("cycle")) || response["confidence"] >= 50.0
          asset.is_bicycle = true
          asset.save
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
  # Delete any posts from db that have no associated images and are created more than 30 miutes ago
  def self.check_posts_without_assets
    Post.find_each do |post|
      if post.assets.count < 0 && post.created_at < 30.minutes.ago
        Post.destroy
      end
    end
  end

  # Called daily
  # Mark random posts for sale
  def self.mark_posts_on_sale
    random_offset = Random.rand(Post.count)
    random_posts = Post.offset(random_offset).first(Post.count / 3)
    random_posts.each do |post|
      if post.sale_price.present? && post.sale_price_expiration.present? && post.created_at < 7.days.ago
        next
      end

      sale_percentage = Random.rand(10)
      sale_price = post.price - ((sale_percentage * post.price) / 100)

      post.sale_price = sale_price
      post.sale_price_expiration = Time.now + 1.day

      post.save
    end
  end

  # Called daily
  # Unmark the posts from sale
  def self.unmark_posts_on_sale
    Post.where("sale_price_expiration <= ?", Time.now).where.not(sale_price: nil).find_each do |post|
      post.sale = nil
      post.sale_price_expiration = nil

      post.save
    end
  end

  # Called every 30 minutes
  # Reset codes for 2FA
  def self.reset_user_codes
    User.where("code_expiration_date <= ?", Time.now).find_each do |user|
      user.code = nil
      user.code_expiration_date = nil

      user.save
    end
  end
end