# frozen_string_literal: true

require 'fileutils'

def generate_index(rb_files, input_dir: 'input', output_dir: 'output', index_file: 'output/index.md', link_prefix: '')
  FileUtils.mkdir_p(File.dirname(index_file))

  entries = {}
  rb_files.sort.each do |rb_path|
    relative_path = rb_path.sub(%r{\A#{Regexp.escape(input_dir)}/}, '')
    folder = relative_path.split('/').first
    md_relative = relative_path.sub(/\.rb\z/, '.md')

    entries[folder] ||= []
    entries[folder] << { md_relative: md_relative, rb_name: File.basename(rb_path) }
  end

  File.open(index_file, 'w') do |f|
    f.puts "# Index\n\n"

    entries.each do |folder, files|
      f.puts "## #{folder}\n\n"
      files.each do |file|
        file_name_html = "#{File.basename(file[:md_relative], '.md')}.html"
        link_path = File.join(link_prefix, file_name_html).gsub('\\', '/')
        display_name = file[:rb_name]

        f.puts "- [#{display_name}](#{link_path})"
      end
      f.puts "\n"
    end
  end
end
