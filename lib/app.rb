# frozen_string_literal: true

# file_path_parser.rb

require_relative 'ollama'

# filepathparser
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
    path.sub(%r{\A\./}, '')
  end

  def validate_path!(path)
    parts = path.split('/')
    return unless parts.size < 2 || parts.any?(&:empty?)

    raise ArgumentError, "パスは 'フォルダ名/ファイル名' 以上の形式で指定してください。"
  end

  def convert_rb_to_md(filename)
    filename.sub(/\.rb\z/, '.md')
  end

  def extract_parent_name(path)
    parts = path.split('/')
    parts[-2]
  end
end

def run_irb_with_script(file_path)
  raise ArgumentError, "ファイルが存在しません: #{file_path}" unless File.exist?(file_path)

  command = "irb --prompt simple < #{file_path}"
  IO.popen(command, 'r', err: %i[child out], &:read)
end

def clean_irb_output(irb_output)
  lines = irb_output.lines

  # `$d` : 最後の行を削除
  lines.pop

  cleaned_lines = lines.map do |line|
    line
      .sub(/^=> /, '#=> ')       # => をコメントに
      .sub(/^\?>   /, '')        # ?> の3スペース除去
      .sub(/^>> $/, '')          # 空行の >> を除去
      .sub(/^.> /, '')           # .> または > を除去
      .sub(/^\.\.\./, '')        # ... を除去
      .sub(/  end$/, 'end')      # end 前の2スペースを除去
  end.reject do |line|
    line.include?('Switch to inspect mode.') # ノイズ行除去
  end

  cleaned_lines.join
end

def process_file(path)
  puts File.basename(path)
  parser = FilePathParser.new(path)

  # ruby irb
  result = run_irb_with_script(path)
  markdown_result = "```ruby\n#{clean_irb_output(result)}```"

  # 出力ファイル名を 親ディレクトリ_ファイル名.md に変更
  joined_name = "#{parser.parent_name}_#{parser.base_name.sub(/\.rb\z/, '.md')}"
  dest = File.join('output', joined_name)

  FileUtils.mkdir_p('output')

  File.open(dest, 'w') do |f|
    # 1. heading1で .rbファイル名を追加
    f.puts
    f.puts "# #{parser.base_name}"
    f.puts

    # 2. 元のMarkdownの内容（存在すれば）
    md_path = File.join(parser.dir_name, parser.md_name)
    if File.exist?(md_path)
      f.puts '<small><strong>Heads up:</strong> This description was created by AI and might not be 100% accurate.</small>'
      f.puts
      f.puts File.read(md_path)
    else
      #cmd = "source venv/bin/activate && python3.13 llm/ask.py \"#{path}\""
      #puts cmd
      #description = `#{cmd}`
      description = describe_output(markdown_result)
      File.write(md_path, description)
      f.puts description
    end
    f.puts
    if File.exist?("#{md_path}x")
      f.puts '### Additional Note'
      f.puts File.read("#{md_path}x")
      f.puts
    end
  end

  # 3. IRB結果をコードブロックで追記
  # result = run_irb_with_script(path)

  File.open(dest, 'a') do |f|
    f.puts "\n### Ruby code snippet\n"
    f.puts markdown_result
    f.puts "\nExecuted with Ruby `#{RUBY_VERSION}`."
  end
  #exit if path.include?("percent")
end
