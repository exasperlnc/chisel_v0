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
  
  def chunk_to_html(chunk)
    # convert_headers if header?
    if header?(chunk)
      convert_headers(chunk)
    else
      # convert paragraphs otherwise
      convert_paragraphs(chunk)
    end
  end

  def header?(chunk)
    chunk[0] == '#'
  end

  def convert_paragraphs(chunk)
    # add the double space to each line
    chunk_lines        = chunk.lines
    indented_lines     = chunk_lines.map { |line| "  #{line.chomp}\n"}
    indented_paragraph = indented_lines.join
    # wrap the lines with <p>
    "<p>\n#{indented_paragraph}</p>"
  end

  def convert_headers(chunk)
    # remove the leading hashes and whitespace
    first_char = chunk.index(' ') + 1
    chunk_text = chunk[first_char..-1]
    # insert the correct tags 
    level      = first_char - 1
    "<h#{level}>#{chunk_text}</h#{level}>" 
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