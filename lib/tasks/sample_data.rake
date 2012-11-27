namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John McCormack",
                 email: "jmccormack321@gmail.com",
                 password: "debbie",
                 password_confirmation: "debbie")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@gmail.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end