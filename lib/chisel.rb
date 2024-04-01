# read the input markdown
markdown = File.read(markdown_file)
# convert it to html
html = Chisel.new(markdown).to_html
# write the html to the output file
File.write(html_file, html)
# print this summary
puts "Converted #{markdown_file} (#{num_lines_markdown} lines) to #{html file} (#{num_lines_html} lines)"
