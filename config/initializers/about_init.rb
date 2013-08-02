begin 
  if About.all.length < 1
    About.create
  end
rescue
  puts "About not created"
end
