namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(firstName: "Miriam",
                 lastName: "Mchome",
                 userName: "mmchome",
                 email: "mirimchome@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      firstName  = Faker::Name.first_name
      lastName  = Faker::Name.last_name
      userName  = "#{n}.#{Faker::Name.last_name}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(firstName:firstName,
                   lastName:lastName,
                   userName: userName,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end