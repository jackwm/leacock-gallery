Grisaille::User.new(
  email: 'carl@contraflo.ws',
  name: 'Carl Suster'
).make_super! '$2a$10$2sBoYNinFl1MtLcVpXpG5OVVgE5x8mngLmW5/3kDjsuIHhJBJZqsG'

Grisaille::User.new(
  email: 'jack@contraflo.ws',
  name: 'Jack Moon'
).make_super! '$2a$10$hVQxdqFQNaTyuWNHF.AjR.AwZyaaF89386mHWTCHSpte3gLdbfbrm'

Grisaille::User.create(
  email: 'anna@leacockgallery.com',
  name: 'Anna Leacock',
  password: 'changemeplz',
  password_confirmation: 'changemeplz'
)

# pages = [
#   {name: 'concept', title: 'Concept & Crew'},
#   {name: 'artist', title: 'The Artist & Her Work'},
#   {name: 'contact', title: 'Contact'}
# ]
# pages.each { |page| Grisaille::Page.create(page) }

Grisaille::Config.finalise!
