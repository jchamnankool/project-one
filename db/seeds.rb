User.destroy_all

u1 = User.create :name => "A", :email => "a@ga.co", :password => "chicken", :streak => 2
u2 = User.create :name => "B", :email => "b@ga.co", :password => "chicken", :streak => 0
u3 = User.create :name => "C", :email => "c@ga.co", :password => "chicken", :streak => 0
u4 = User.create :name => "D", :email => "d@ga.co", :password => "chicken", :streak => 0
u5 = User.create :name => "E", :email => "e@ga.co", :password => "chicken", :streak => 0
u6 = User.create :name => "F", :email => "f@ga.co", :password => "chicken", :streak => 0
u7 = User.create :name => "G", :email => "g@ga.co", :password => "chicken", :streak => 0
u8 = User.create :name => "H", :email => "h@ga.co", :password => "chicken", :streak => 0
u9 = User.create :name => "I", :email => "i@ga.co", :password => "chicken", :streak => 0
u10 = User.create :name => "Jackie", :email => "j@ga.co", :password => "chicken", :streak => 0, :admin => true
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