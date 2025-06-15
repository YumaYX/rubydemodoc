# file_path_parser.rb

class FilePathParser
  attr_reader :dir_name, :base_name, :md_name, :parent_name

  def initialize(path)
    normalized = normalize_path(path)
    validate_path!(normalized)

    @base_name   = File.basename(normalized)
    @md_name     = convert_rb_to_md(@base_name)
    @dir_name    = File.dirname(normalized)
    @parent_name = extract_parent_name(normalized)
  end

  def markdown_exist?
    File.exist?(File.join(@dir_name, @md_name))
  end

  private

  def normalize_path(path)
    path.sub(/\A\.\//, "")
  end

  def validate_path!(path)
    parts = path.split("/")
    if parts.size < 2 || parts.any?(&:empty?)
      raise ArgumentError, "パスは 'フォルダ名/ファイル名' 以上の形式で指定してください。"
    end
  end

  def convert_rb_to_md(filename)
    filename.sub(/\.rb\z/, ".md")
  end

  def extract_parent_name(path)
    parts = path.split("/")
    parts[-2]
  end
end


require 'rake'

file_list = FileList['input/**/*.rb']

file_list.each do |path|
  parser = FilePathParser.new(path)

  if parser.markdown_exist?
    src  = File.join(parser.dir_name, parser.md_name)
    dest = File.join("output", parser.md_name)

    FileUtils.cp(src, dest)

    puts "Copied: #{src} → #{dest}"
  else
    File.write(dest, "")
    puts "✗ Markdown not found. Created empty: #{dest}"
  end
  p parser
end
