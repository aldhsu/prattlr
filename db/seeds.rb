# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Message.destroy_all
Room.destroy_all

u1 = User.create(username: '123456', password: 'a', password_confirmation: 'a', email: 'ua@ua.com')
u2 = User.create(username: '123457', password: 'b', password_confirmation: 'b', email: 'ub@ub.com')

m1 = Message.create(content: 'first message')
m2 = Message.create(content: 'second message')
m3 = Message.create(content: 'third message')
m1.children << m2
u1.messages << m1
u2.messages << m2 << m3

r1 = Room.create(topic: 'javascript')
r1.users << u1 << u2
r1.messages << m1 << m2 << m3

