# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name: 'admin_user',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true
    },
    {
      name: 'test',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    },
    {
      name: 'sample',
      email: 'sample@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    }
  ]
)

3.times do |n|
  User.all.each do |user|
    user.tasks.create!(
      title: "test#{n}",
      content: "sample#{n}",
      deadline: Date.current + (n).days,
      status: n,
      priority: n
    )
  end
end
