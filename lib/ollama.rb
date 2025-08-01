# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

def ollama_request(prompt)
  url = URI.parse('http://localhost:11434/api/generate')
  data = {
    "model": 'gemma3:27b',
    "prompt": prompt,
    "stream": false,
    "temperature": 0.1
  }
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')
  http.open_timeout = 600 # 接続タイムアウト（秒）
  http.read_timeout = 60 * 60 * 6 # レスポンス読み取りタイムアウト（秒）

  request = Net::HTTP::Post.new(url.path, {
                                  'Content-Type' => 'application/json'
                                })
  request.body = data.to_json
  response = http.request(request)
  JSON.parse(response.body)['response']
end

def describe_codes(file_name)
  content = File.read(file_name)
  content = "Write about the following ruby codes in English using markdown format. Just the answer. Start your response with 'This Ruby code snippet demonstrates'.\n---\n#{content}"
  ollama_request(content)
end

def describe_output(result)
  content = "Write about the following ruby codes in English using markdown format, in briefly. Just the answer. Start your response with 'This Ruby code snippet demonstrates'.\n---\n#{result}"
  ollama_request(content)
end

