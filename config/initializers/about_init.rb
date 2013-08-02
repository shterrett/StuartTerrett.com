begin 
  if About.all.length < 1
    About.create
  end
end
rescue
  puts "About not created"
end
