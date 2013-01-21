# Geodist

A fast and simple geographical distance calculator. This module calculates
"as the crow flies" distance between two points using the [haversine formula](http://en.wikipedia.org/wiki/Haversine_formula).

## Installation

Install using npm:

    $ npm install geodist

## Example

To get the mileage between two points, pass in the coordinates in decimal
format.

    var geodist = require('geodist')

    var dist = geodist({lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881})
    console.log(dist)           
    // => 587

## Usage

#### geodist(start, end, [options])

The following options are supported:

* `unit`   - Return results in the unit of measurement. Defaults to miles, see below for available types.
* `format` - Return results as a string with the measurement type. Defaults to false.
* `exact`  - Return exact results as a floating point. Defaults to false.
* `limit`  - Specify a maximum distance here and `true` will be returned if the distance is less, or `false` if it is exceeded.

The following types are accepted in the `unit` option:

* `miles` or `mi`
* `yards`
* `feet`
* `kilometers` or `km`
* `meters`

Examples:

    var geodist = require('geodist')

    var tokyo = {lat: 35.6833, lon: 139.7667}    
    var osaka = {lat: 34.6603, lon: 135.5232}

    geodist(tokyo, osaka)                                // => 249

    geodist(tokyo, osaka, {exact: true, unit: 'km'})     // => 402.09212137829695

    geodist(tokyo, osaka, {format: true, unit: 'feet'})  // => 1319614 feet
 
    geodist(tokyo, osaka, {limit: 200})                  // => false 

    geodist(tokyo, osaka, {limit: 250})                  // => true 

## Coordinate formats

Coordinates are always in decimal format and can be passed in one of three
ways:

##### An object hash with explicit lat/lon keys:

    var dist = geodist({lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881})

##### An object hash with arbitrary keys (in lat/lon order):

    var dist = geodist({x: 41.85, y: -87.65}, {latitude: 33.7489, longitude: -84.3881})

##### An array (in lat/lon order):

    var dist = geodist([41.85, -87.65], [33.7489, -84.3881])

## Running the tests

To run the test suite, invoke the following commands in the repository:

    $ npm install
    $ npm test

## Acknowledgements

Thanks to [Movable Type](http://www.movable-type.co.uk/scripts/latlong.html) for supplying
the initial JavaScript implementation of the haversine formula that this is based on.
