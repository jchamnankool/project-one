User.destroy_all

u1 = User.create :email => "a@ga.co", :password => "chicken"
u2 = User.create :email => "b@ga.co", :password => "chicken"
puts "#{ User.count } users created."

Entry.destroy_all

e1 = Entry.create :tidbits => ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Proin arcu tortor, fringilla ut sapien id, convallis congue odio. In ornare tempor diam sit amet tincidunt.", "Pellentesque vulputate mauris quis sollicitudin accumsan."], :date => "2022-07-22"
e2 = Entry.create :tidbits => ["Nulla placerat ultrices orci quis feugiat. Nam convallis, urna quis suscipit feugiat, nisi ante imperdiet libero, volutpat bibendum lectus risus quis tellus.", "Nam eu feugiat lorem.", "In posuere porta diam."], :date => "2022-07-21"
puts "#{ Entry.count } entries created."

# Associations
puts "Users and entries"
u1.entries << e1 << e2