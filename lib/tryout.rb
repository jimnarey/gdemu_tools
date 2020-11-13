# frozen_string_literal: false

def try_func(*args)
  args.each { |arg| puts arg }
end

try_func('one', 'two', 'three')
