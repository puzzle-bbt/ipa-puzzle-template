#!/usr/bin/env ruby

require 'open3'
require 'optparse'

def run_command(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  unless status.success?
    puts "Error running command: #{cmd}"
    puts stderr
    exit 1
  end
  stdout
end

def escape_underscores(string)
  string.gsub("_", "\\_")
end

#parameters
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: script.rb [options]"

  opts.on("-c", "--compare [COMMIT]", "Compare to a specific commit or branch (default is 'master')") do |c|
    options[:compare] = c || "master"
  end

  opts.on("-d", "--directory DIRECTORY", "Directory of the Git repository") do |d|
    options[:directory] = d
  end
end.parse!

# go to directory
if options[:directory]
  Dir.chdir(options[:directory])
  puts "Running for this directory: #{options[:directory]}"
end

# git diff defautls to master, but when we want to compare to certain branch, we can pass it as param
comparison_target = options[:compare] || "master"

diff_output = run_command("git diff #{comparison_target}")

parsed_output = ""
current_file = nil
lines_to_skip = 0

diff_output.each_line do |line|
  if line.start_with?('diff --git')
    parsed_output += "\\end{lstlisting}\n\n" unless parsed_output.empty?

    match = line.match(/^diff --git a\/(.+?) b\/(.+?)$/)
    if match
      current_file = escape_underscores(match[1])
      parsed_output += "\\begin{lstlisting}[caption=#{current_file}, firstnumber=1]\n"
    end

    lines_to_skip = 4
  elsif lines_to_skip > 0
    lines_to_skip -= 1
  else
    parsed_output += line
  end
end

parsed_output += "\\end{lstlisting}\n" unless parsed_output.empty?

File.open("code.txt", "w") do |file|
  file.write(parsed_output)
end

puts "Diff output written to code.txt"

