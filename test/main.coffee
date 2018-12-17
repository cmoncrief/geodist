assert  = require 'assert'
geodist = require '../lib/geodist'
coords  = require './coordinates.json'


describe 'Distance', ->

  it 'should calculate miles between Chicago and Atlanta', ->
    dist = geodist coords.chicago, coords.atlanta
    assert.equal dist, 587

  it 'should calculate miles between Los Angeles and San Francisco', ->
    dist = geodist coords.losAngeles, coords.sanFrancisco
    assert.equal dist, 347

  it 'should calculate miles between Tokyo and Osaka', ->
    dist = geodist coords.tokyo, coords.osaka
    assert.equal dist, 249

  it 'should calculate miles between Paris and Berlin', ->
    dist = geodist coords.paris, coords.berlin
    assert.equal dist, 545


describe 'Limits', ->

  it 'should return false if the limit is exceeded', ->
    dist = geodist coords.tokyo, coords.osaka, {limit: 200}
    assert.equal dist, false

  it 'should return true if the limit is not exceeded', ->
    dist = geodist coords.tokyo, coords.osaka, {limit: 250}
    assert.equal dist, true

  it 'should return true if the limit is equal the distance', ->
    dist = geodist coords.tokyo, coords.tokyo, {limit: 0}
    assert.equal dist, true


describe 'Units', ->

  it 'should calculate miles between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'miles'}
    assert.equal dist, 12432

  it 'should calculate mi between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'mi'}
    assert.equal dist, 12432

  it 'should calculate yards between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'yards'}
    assert.equal dist, 21881899

  it 'should calculate feet between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'feet'}
    assert.equal dist, 65645699

  it 'should calculate km between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'km'}
    assert.equal dist, 20002

  it 'should calculate kilometers between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'kilometers'}
    assert.equal dist, 20002

  it 'should calculate meters between Cordoba and Hamilton', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'meters'}
    assert.equal dist, 20002522

  it 'should calculate in miles when an invalid unit is set', ->
    dist = geodist coords.cordoba, coords.hamilton, {unit: 'invalid'}
    assert.equal dist, 12432


describe 'Coordinate formats', ->

  it 'should support explicit lat/lon coordinate hashes', ->
    dist = geodist coords.chicago, coords.atlanta
    assert.equal dist, 587

  it 'should support arbitrary lat/lon coordinate hashes', ->
    dist = geodist {x: 41.85, y: -87.65}, {latitude: 33.7489, longitude: -84.3881}
    assert.equal dist, 587

  it 'should support lat/lon coordinate arrays', ->
    dist = geodist [41.85, -87.65], [33.7489, -84.3881]
    assert.equal dist, 587

  it 'should support mixed coordinate formats', ->
    dist = geodist {x: 41.85, y: -87.65}, [33.7489, -84.3881]
    assert.equal dist, 587


describe 'Output options', ->

  it 'should output whole numbers by default', ->
    dist = geodist coords.chicago, coords.atlanta
    assert.equal dist, 587

  it 'should output decimals when exact option is set', ->
    dist = geodist coords.chicago, coords.atlanta, {exact: true}
    assert.equal dist, 587.433877752553

  it 'should output miles string when format option is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true}
    assert.equal dist, '587 miles'

  it 'should output mi string when format and km unit is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true, unit: 'mi'}
    assert.equal dist, '587 mi'

  it 'should output yards string when format and yards unit is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true, unit: 'yards'}
    assert.equal dist, '1033883 yards'

  it 'should output feet string when format and feet unit is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true, unit: 'feet'}
    assert.equal dist, '3101650 feet'

  it 'should output km string when format and km unit is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true, unit: 'km'}
    assert.equal dist, '945 km'

  it 'should output kilometers string when format and kilometers unit is set', ->
    dist = geodist coords.chicago, coords.atlanta, {format: true, unit: 'kilometers'}
    assert.equal dist, '945 kilometers'


describe 'Benchmark', ->

  it 'should calculate 1 million times in less than 1s', ->
    @timeout 1000
    i = 0
    while i++ < 1000000
      geodist coords.chicago, coords.atlanta