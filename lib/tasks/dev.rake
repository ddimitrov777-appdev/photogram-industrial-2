task sample_data: :environment do
  starting = Time.now
  p "Creating sample data"

  #delete all existing entries so we don't have mass accumulation of these records
  FollowRequest.delete_all
  Comment.delete_all
  Like.delete_all
  Photo.delete_all
  User.delete_all

  usernames = []
  10.times do
    usernames << Faker::Name.first_name
  end
  

  
  usernames << "alice"

  usernames << "bob"

  usernames.each do |username|
  #10.times do
    #name = Faker::Name.first_name
    User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true, false].sample

    )
  

      #user = User.new.tap do |u|
         # u.build_profile
         # u.process_credit_card
         # u.ship_out_item
         # u.send_email_confirmation
         # u.blahblahyougetmypoint
      # end

  
  end


  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.values.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.values.sample
        )
      end
    end
  end

  #now we create photos and commonts
   users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end
 
   ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."

end