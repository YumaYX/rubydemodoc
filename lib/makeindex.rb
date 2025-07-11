# frozen_string_literal: true

require 'fileutils'
require_relative 'app'

def generate_index(rb_files, input_dir: 'input', output_dir: 'output', index_file: 'output/index.md', link_prefix: '')
  FileUtils.mkdir_p(File.dirname(index_file))

  entries = {}

  rb_files.sort.each do |rb_path|
    parser = FilePathParser.new(rb_path)
    md_filename = "#{parser.parent_name}_#{parser.base_name.sub(/\.rb$/, '.md')}"
    html_filename = md_filename.sub(/\.md$/, '.html')

    entries[parser.parent_name] ||= []
    entries[parser.parent_name] << {
      link: File.join(link_prefix, html_filename).gsub('\\', '/'),
      display: parser.base_name
    }
  end

  File.open(index_file, 'w') do |f|
    f.puts "# Index\n\n"

    entries.each do |folder, files|
      f.puts "## #{folder}\n\n"
      files.each do |file|
        f.puts "- [#{file[:display]}](#{file[:link]})"
      end
      f.puts "\n"
    end
    f.puts "##### Github Repository\n<https://github.com/YumaYX/rubydemodoc>"
  end
end

