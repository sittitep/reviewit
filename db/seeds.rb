# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Branch.create(name: "Master", description: "force push is not allowed")
Branch.create(name: "news", description: "things worth your brain cells")
Branch.create(name: "MEME", description: "what keep you alive")

user = User.create(
  name: "Sittitep Tosuwan",
  email: "sittitep.tosuwan@gmail.com",
  avatar_url: "https://avatars1.githubusercontent.com/u/2796887?v=4",
  github_id: "2796887",
  profile_url: "https://github.com/sittitep"
)

Branch.all.each do |branch|
  Moderator.create(user: user, branch: branch)
end
