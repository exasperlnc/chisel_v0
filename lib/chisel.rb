class Chisel
  def initialize(markdown)
    @markdown = markdown
  end

  def to_html
    markdown_chunks = string_to_chunks(@markdown)
    html_chunks = markdown_chunks.map do |chunk|
      chunk_to_html(chunk)
    end
    chunks_to_string(html_chunks)
  end

  def string_to_chunks(string)
    string.split(/\n\n+/)
  end
end
markdown_file = ARGV[0]
html_file = ARGV[1]

program_running = ($PROGRAM_NAME == __FILE__)
if program_running
  # read the input markdown
  markdown = File.read(markdown_file)
  # convert it to html
  html = Chisel.new(markdown).to_html
  # write the html to the output file
  File.write(html_file, html)
  # print this summary
  num_lines_markdown = markdown.lines.count
  num_lines_html = html.lines.count

  puts "Converted #{markdown_file} (#{num_lines_markdown} lines) to #{html_file} (#{num_lines_html} lines)"
end