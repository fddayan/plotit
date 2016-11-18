require 'date'
require 'active_support/all'

def write_to(file, &block)
  file_path = "./spec/fixtures/#{file}"
  File.open(file_path,'w', &block)
  puts "Generate #{file_path}"
end

write_to 'timeline.txt' do |f|
  now = Time.now
  2000.times do |n|
    l = now + (1.seconds * n)
    f.write("#{l}\t#{rand(100)}\n")
  end
end

write_to 'timeline_multi_lines.txt' do |f|
  now = Time.now
  2000.times do |n|
    l = now + (1.seconds * n)
    f.write("#{l}\t#{rand(100)}\t#{rand(100)}\n")
  end
end

write_to 'bar.txt' do |f|
  10.times do |n|
    f.write("Name#{n}\t#{rand(100)}\n")
  end
end

write_to 'bar_multi_lines.txt' do |f|
  10.times do |n|
    f.write("Name#{n}\t#{rand(100)}\t#{rand(100)}\n")
  end
end



