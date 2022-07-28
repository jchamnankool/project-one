User.destroy_all

u1 = User.create :name => "Alice", :email => "a@ga.co", :password => "chicken"
u2 = User.create :name => "Ben", :email => "b@ga.co", :password => "chicken"
u3 = User.create :name => "Celine", :email => "c@ga.co", :password => "chicken"
u4 = User.create :name => "Derek", :email => "d@ga.co", :password => "chicken"
u5 = User.create :name => "Elliot", :email => "e@ga.co", :password => "chicken"
u6 = User.create :name => "Florence", :email => "f@ga.co", :password => "chicken"
u7 = User.create :name => "Gary", :email => "g@ga.co", :password => "chicken"
u8 = User.create :name => "Hans", :email => "h@ga.co", :password => "chicken"
u9 = User.create :name => "Ingrid", :email => "i@ga.co", :password => "chicken"
u10 = User.create :name => "Jackie", :email => "j@ga.co", :password => "chicken", :admin => true
puts "#{ User.count } users created."

Entry.destroy_all

e1 = Entry.create :tidbits => ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Proin arcu tortor, fringilla ut sapien id, convallis congue odio. In ornare tempor diam sit amet tincidunt.", "Pellentesque vulputate mauris quis sollicitudin accumsan."]
e2 = Entry.create :tidbits => ["Nulla placerat ultrices orci quis feugiat. Nam convallis, urna quis suscipit feugiat, nisi ante imperdiet libero, volutpat bibendum lectus risus quis tellus.", "Nam eu feugiat lorem.", "In posuere porta diam."]
e3 = Entry.create :tidbits => ["Sapien pellentesque habitant morbi tristique senectus et netus et malesuada.", "Faucibus nisl tincidunt eget nullam non nisi est sit.", "Gravida rutrum quisque non tellus orci ac auctor."]
puts "#{ Entry.count } entries created."

# Associations
puts "Users and entries"
u1.entries << e1 << e2
u2.entries << e3