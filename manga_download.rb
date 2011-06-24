
#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

BROWSER = Mechanize.new { |agent|  agent.user_agent_alias = "Mac Safari"}

def getit! dir_name, target_url
  puts ">>>> #{target_url}"

  begin
    BROWSER.get(target_url) do |page|
      next_url = "http://"
      next_url << page.uri.host
      next_url << page.search('.//div[@id="imgholder"]//a').attr('href').to_s

      url = page.search('.//div[@id="imgholder"]//img').attr('src').to_s

      name = (page.title.gsub(/[\ \/:]/, '_')+"."+url.split('.').last).gsub /[:\/]/,''

      puts ">>>> Downloading #{name} (#{url})"

      puts `curl #{url} > #{dir_name}/#{name}`
      puts "="*16
      getit! dir_name, next_url
    end
  rescue
    puts "Failed at #{target_url}"
    exit 1
  end
end

puts "usage: \nruby manga_download.rb <DIR> '<STARTURL>'" and exit  1 if ARGV.length < 2
getit! ARGV[0], ARGV[1]
