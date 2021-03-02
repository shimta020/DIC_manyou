# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
      name: 'admin_user',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true
)

11.times do |n|
  User.create!(
    name: "test#{n}",
    email: "test#{n}@example.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
end

12.times do |n|
  User.all.each do |user|
    user.tasks.create!(
      title: "task#{n}",
      content: "sample#{n}",
      deadline: Date.current + (n).days,
      status: rand(0..2),
      priority: rand(0..2)
    )
  end
end

Label.create!(
  [
    {label_name: '勉強'},
    {label_name: 'プログラミング'},
    {label_name: '授業'},
    {label_name: '会議'},
    {label_name: '出張'},
    {label_name: '家事'},
    {label_name: '息抜き'},
    {label_name: 'ライブ'},
    {label_name: '飲み会'},
    {label_name: 'その他'},
  ]
)