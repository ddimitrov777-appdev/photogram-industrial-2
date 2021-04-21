task sample_data: :environment do
  starting = Time.now
  p "Creating sample data"

  #delete all existing entries so we don't have mass accumulation of these records
  FollowRequest.delete_all
  Comment.delete_all
  Like.delete_all
  Photo.delete_all
  User.delete_all

  12.times do
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name}@example.com",
      username: name.downcase,
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

  users.each |first_user| do


    users.each |second_user| do
        if rand <0.75
            first_user.sent_follow_requests.create(
              recipient: second_user,
              status: ["pending","accepted","rejected"].sample
            )
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