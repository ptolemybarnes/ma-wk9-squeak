def create_user
   user = User.new(email: 'example@test.com', password: 'password',
                       password_confirmation: 'password')
   user.save
   user 
end

