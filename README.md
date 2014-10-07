*This is a fork of [cmoncrief/geodist](https://github.com/cmoncrief/geodist)*

A fast and simple geographical distance calculator. This module calculates "as the crow flies" distance between two points using the [haversine formula](http://en.wikipedia.org/wiki/Haversine_formula).

## Usage

```js
  var geodist = require('geodist')
    , dist = geodist({lat: 41.85, lon: -87.65}, {lat: 33.7489, lon: -84.3881});
  console.log(dist) //=> 587
```

## API

**geodist(start, end, [options])**: Retrieve geographic distance between `start` and `end` ***decimal*** lat/lon coordinates.

The following options are supported:
* `unit`   - Return results in the unit of measurement. Defaults to meters, see below for available types.
* `format` - Return results as a string with the measurement type. Defaults to false.
* `exact`  - Return exact results as a floating point. Defaults to false.
* `limit`  - Specify a maximum distance here and `true` will be returned if the distance is less, or `false` if it is exceeded.

The following types are accepted in the `unit` option:
* `miles` or `mi`
* `yards`
* `feet`
* `kilometers` or `km`
* `meters` or `m`

```js
  var geodist = require('geodist')
    , tokyo = {lat: 35.6833, lon: 139.7667}
    , osaka = {lat: 34.6603, lon: 135.5232};

  geodist(tokyo, osaka)                                // => 402092
  geodist(tokyo, osaka, {exact: true, unit: 'km'})     // => 402.09212137829695
  geodist(tokyo, osaka, {format: true, unit: 'feet'})  // => 1319614 feet
  geodist(tokyo, osaka, {limit: 200})                  // => false
  geodist(tokyo, osaka, {limit: 250})                  // => true
```

Thanks to [Movable Type](http://www.movable-type.co.uk/scripts/latlong.html) for supplying
the initial JavaScript implementation of the haversine formula that this is based on.
