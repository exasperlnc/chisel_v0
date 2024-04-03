require 'minitest/autorun'
require './lib/chisel'

class TestChisel < Minitest::Test

  def test_markdown_to_html
    skip 
    markdown = '# My Life in Desserts

    ## Chapter 1: The Beginning
    
    "You just *have* to try the cheesecake," he said. "Ever since it appeared in
    **Food & Wine** this place has been packed every night."'
    expected_html = '<h1>My Life in Desserts</h1>

    <h2>Chapter 1: The Beginning</h2>
    
    <p>
      "You just <em>have</em> to try the cheesecake," he said. "Ever since it appeared in
      <strong>Food &amp; Wine</strong> this place has been packed every night."
    </p>'

    actual_html = Chisel.new(markdown).to_html
    assert_equal expected_html, actual_html
  end

  def test_it_considers_blank_lines_to_delimit_chunks
    markdown        = "a\nb\n\nc\n\n\nd"
    actual_chunks   = Chisel.new("").string_to_chunks(markdown)
    expected_chunks = ["a\nb", "c", "d"]
    assert_equal expected_chunks, actual_chunks
  end

  def test_it_converts_chunks_beginning_with_hashes_into_headers_of_that_level
    input_chunk = "# My Life In Desserts"
    expected_html = "<h1>My Life In Desserts</h1>"
    output        = Chisel.new("").chunk_to_html(input_chunk)
    assert_equal expected_html, output
  end

  def test_it_converts_every_other_chunk_into_a_paragraph
    skip
  end
end