{print}       = require 'util'
{spawn, exec} = require 'child_process'
path          = require 'path'

option '-p', '--path [PATH]', 'Test path to run (from tests/)'

task 'test', (options) ->

  testPath = ''

  if options.path
    testPath = path.join 'test/', "#{options.path}.coffee"

  exec "NODE_ENV=test 
    ./node_modules/.bin/mocha
    #{testPath}
    --compilers coffee:coffee-script
    --require coffee-script
    --colors
    --reporter spec
    --timeout 20000
  ", (err, output) ->
    throw err if err
    console.log output

task 'build', 'Compile CoffeeScript source files', ->

  build false

task 'watch', 'Watch CoffeeScript files for changes', ->

  build true

build = (watch) ->

  options = ['-b', '-c', '-o', 'lib/', 'src/']

  if watch then options.unshift '-w'

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data
  coffee.stderr.on 'data', (data) -> print data