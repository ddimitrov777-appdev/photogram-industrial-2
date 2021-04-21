task sample_data: :environment do
  p "Creating sample data"

  12.times do
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name}@example.com",
      username: name,
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

    
   
   p u.errors.full_messages
  end
 p "#{User.count} users have been created."

end