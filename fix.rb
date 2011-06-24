require 'fileutils'
include FileUtils
Dir[ "*.jpg" ].each do | file |
  name = file =~ /Page\_\d\.jpg/ ?  file.sub('Page_', 'Page_0') : file
  dirname = file.split('-').first.sub(/_$/,'')

  final_path = dirname + "/" + name
  begin
    mkdir dirname
  rescue; end
  puts "#{file} => #{final_path}"
  mv file, final_path
end

puts "end"
