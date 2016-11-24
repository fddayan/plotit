require 'date'
require 'active_support/all'

def write_to(file, number, &block)
  file_path = "./spec/fixtures/#{file}"
  File.open(file_path,'w') do |f|
    number.times do |n|
      f.write "#{block.call(n).join("\t")}\n"
    end
  end

  puts "Generate #{file_path}"
end

puts "Grupped data"
ips = ['184.75.214.42', '90.75.214.60']
names = 3.times.map { |n| "Name#{n}" }
now = Time.now

write_to 'groupped/string_string_number.txt', 20 do |n|
  [names.sample, ips.sample, rand(100)]
end

write_to 'groupped/date_string_number.txt', 100 do |n|
  [(now + (10.seconds * n)), ips.sample, rand(100)]
end

# write_to 'timeline.txt' do |f|
#   now = Time.now
#   2000.times do |n|
#     l = now + (1.seconds * n)
#     f.write("#{l}\t#{rand(100)}\n")
#   end
# end

# write_to 'timeline_multi_lines.txt' do |f|
#   now = Time.now
#   2000.times do |n|
#     l = now + (1.seconds * n)
#     f.write("#{l}\t#{rand(100)}\t#{rand(100)}\n")
#   end
# end

# write_to 'bar.txt' do |f|
#   10.times do |n|
#     f.write("Name#{n}\t#{rand(100)}\n")
#   end
# end

# write_to 'bar_multi_lines.txt' do |f|
#   10.times do |n|
#     f.write("Name#{n}\t#{rand(100)}\t#{rand(100)}\n")
#   end
# end

# write_to 'date_counts.txt' do |f|
#   now = Time.now
#   10.times do |n|
#     l = now + (1.seconds * n)
#     f.write("#{l}\t#{rand(100)}\n")
#   end
# end

# write_to 'name_ips.txt' do |f|
#   10.times do |n|
#     f.write("Name#{rand(3)}\tt184.75.214.42\n")
#   end
# end

# write_to 'name_counts.txt' do |f|
#   10.times do |n|
#     f.write("Name#{rand(3)}\t#{rand(100)}\n")
#   end
# end



