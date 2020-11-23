# frozen_string_literal: false

require 'rake/testtask'

task default: 'test'

Rake::TestTask.new do |task|
  task.pattern = './test/test_*.rb'
end
