# frozen_string_literal: true
#
require 'rake'
require_relative './lib/app'
require_relative './lib/makeindex'
require 'rake/clean'

# 出力ディレクトリのクリーン設定
CLEAN.include('output/*')

desc 'Process all .rb files under input/'
task :process_all do
  FileList['input/**/*.rb'].each do |path|
    process_file(path)
  end
end

desc 'Generate Markdown index from input/**/*.rb files'
task :generate_index do
  file_list = FileList['input/**/*.rb']
  generate_index(file_list, link_prefix: '/rubydemodoc/')
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.options = ['--format', 'simple']
end

task default: %i[clean generate_index process_all]

