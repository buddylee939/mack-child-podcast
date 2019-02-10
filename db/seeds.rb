# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


20.times do |p|
 pod = Podcast.create!(
    title: "Podcast no:#{p}",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis aliquam quidem, ipsum in quos. Dolorem alias, aliquid culpa magni quaerat incidunt non earum odit, cupiditate minima amet, numquam voluptatum reprehenderit!",
    email: "abby#{p}@example.com",
    itunes: "#",
    stitcher: "#",
    podbay: "#",
    password: 'asdfasdf',
    password_confirmation: 'asdfasdf', 
  )
 pod.podcast_image.attach(
  io: File.open('app/assets/images/logo6.jpg'), 
  filename: 'logo6.jpg', 
  content_type: 'image/jpg'
 )

end

puts '20 podcasts created'

100.times do |e|
  ep = Episode.create!(
    title: " Episode #{e}",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Architecto voluptatem ipsum sapiente, maxime! Nostrum eos, odio asperiores quis incidunt molestias.",
    podcast_id: rand(1..20)
  )
  ep.mp3_file.attach(
    io: File.open('app/assets/images/1-01 Survival.mp3'), 
    filename: '1-01 Survival.mp3', 
    content_type: 'audio/mpeg'
  )
  ep.episode_image.attach(
    io: File.open('app/assets/images/logo1.jpg'), 
    filename: 'logo1.jpg', 
    content_type: 'image/jpg'    
  )
end

puts '100 episodes created'
