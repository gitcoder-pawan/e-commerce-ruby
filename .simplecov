SimpleCov.start 'rails' do
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/test/'
  add_filter '/vendor/'
end