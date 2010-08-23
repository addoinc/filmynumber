require 'factory_girl'
require 'faker'

Factory.define :theater do |t|
  t.name Faker::Company.name
end

Factory.define :movie do |m|
  m.name Faker::Name.name
end

Factory.define :show do |s|
  s.start 1.days.ago
  s.association :movie, :factory => :movie
  s.association :theater, :factory => :theater
end

Factory.define :user do |u|
  u.email Faker::Internet.email
  u.password "letmein"
  u.password_confirmation "letmein"
end

Factory.define :opinion do |o|
  o.association :user, :factory => :user
  o.association :movie,:factory => :movie
  o.seen true
  o.watchable true
  o.watchable_twice true
  o.watchable_multi true
end
