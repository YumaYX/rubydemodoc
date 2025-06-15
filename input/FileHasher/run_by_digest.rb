require 'ys1'

hasher = YS1::FileHasher.new(["lib/**/*.rb"])

hasher.run_by_digest
