assert  = require 'assert'
geodist = require '../lib/geodist'

describe 'Distance', ->

  it 'should calculate miles between Chicago and Atlanta', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}
    assert.equal dist, 587

  it 'should calculate miles between Los Angeles and San Francisco', ->
    dist = geodist {lat: 34.0522, lon: -118.2428}, {lat: 37.7750, lon: -122.4183}
    assert.equal dist, 347

  it 'should calculate miles between Tokyo and Osaka', ->
    dist = geodist {lat: 35.6833, lon: 139.7667}, {lat: 34.6603, lon: 135.5232}
    assert.equal dist, 249

  it 'should calculate miles between Paris and Berlin', ->
    dist = geodist {lat: 48.8742, lon: 2.3470}, {lat: 52.5233, lon: 13.4127}
    assert.equal dist, 545

describe 'Limits', ->

  it 'should return false if the limit is exceeded', ->
    dist = geodist {lat: 35.6833, lon: 139.7667}, {lat: 34.6603, lon: 135.5232}, {limit: 200}
    assert.equal dist, false

  it 'should return true if the limit is not exceeded', ->
    dist = geodist {lat: 35.6833, lon: 139.7667}, {lat: 34.6603, lon: 135.5232}, {limit: 250}
    assert.equal dist, true

describe 'Units', ->

  it 'should calculate miles between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'miles'}
    assert.equal dist, 11922

  it 'should calculate mi between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'mi'}
    assert.equal dist, 11922

  it 'should calculate yards between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'yards'}
    assert.equal dist, 20983263

  it 'should calculate feet between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'feet'}
    assert.equal dist, 62949789

  it 'should calculate km between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'km'}
    assert.equal dist, 19181

  it 'should calculate kilometers between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'kilometers'}
    assert.equal dist, 19181

  it 'should calculate meters between Cordoba and Hamilton', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'meters'}
    assert.equal dist, 19181067

  it 'should calculate in miles when an invalid unit is set', ->
    dist = geodist {lat: 37.8833, lon: 4.7833}, {lat: -37.7833, lon: 175.2833}, {unit: 'invalid'}
    assert.equal dist, 11922

describe 'Coordinate formats', ->
    
  it 'should support explicit lat/lon coordinate hashes', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}
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
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}
    assert.equal dist, 587

  it 'should output decimals when exact option is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {exact: true}
    assert.equal dist, 587.4338777525531

  it 'should output miles string when format option is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true}
    assert.equal dist, '587 miles'

  it 'should output mi string when format and km unit is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true, unit: 'mi'}
    assert.equal dist, '587 mi'

  it 'should output yards string when format and yards unit is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true, unit: 'yards'}
    assert.equal dist, '1033883 yards'

  it 'should output feet string when format and feet unit is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true, unit: 'feet'}
    assert.equal dist, '3101650 feet'

  it 'should output km string when format and km unit is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true, unit: 'km'}
    assert.equal dist, '945 km'

  it 'should output kilometers string when format and kilometers unit is set', ->
    dist = geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}, {format: true, unit: 'kilometers'}
    assert.equal dist, '945 kilometers'

describe 'Benchmark', ->

  it 'should calculate 1 million times in less than 1s', ->
    @timeout 1000
    i = 0
    while i++ < 1000000
      geodist {lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881}
