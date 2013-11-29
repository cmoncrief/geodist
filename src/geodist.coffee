# geodist
# Copyright (c) 2013 Charles Moncrief <cmoncrief@gmail.com>
# MIT Licensed

radiusUnits = 
  'feet': 20908800
  'yards': 6969600
  'miles': 3960
  'mi': 3960
  'kilometers': 6371
  'km': 6371
  'meters': 6371000

# Returns the distance between two points. Takes two points in varying
# formats and an options hash.

getDistance = (start, end, options = {}) ->

  [lat1, lon1] = parseCoordinates start
  [lat2, lon2] = parseCoordinates end
 
  earthRadius = getEarthRadius(options.unit)

  latDelta = (lat2 - lat1) * Math.PI / 180
  lonDelta = (lon2 - lon1) * Math.PI / 180

  lat1Rad = lat1 * Math.PI / 180
  lat2Rad = lat2 * Math.PI / 180

  a = Math.sin(latDelta / 2) * Math.sin(latDelta / 2) + 
      Math.sin(lonDelta / 2) * Math.sin(lonDelta / 2) * 
      Math.cos(lat1Rad) * Math.cos(lat2Rad)

  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  
  distance = earthRadius * c
  distance = Math.floor(distance) unless options.exact

  if options.limit
    if options.limit > distance then return true else return false

  distance = "#{distance} #{options.unit || 'miles'}" if options.format

  return distance

# Parses the latitude and longitude coordinates from the specfied point
# argument and returns an array of [lat, lon].

parseCoordinates = (point = [0,0]) ->

  coords = []

  if point instanceof Array
    coords = point
  else if point.lat? and point.lon?
    coords = [point.lat, point.lon]
  else if typeof point is 'object'
    coords.push(val) for key, val of point
  else
    coords = point

  return coords

# Returns the radius of the earth in the specfied units.

getEarthRadius = (unit = "miles") ->

  unit = unit.toLowerCase()
  unit = "miles" unless radiusUnits[unit]
  radiusUnits[unit]

# Expose the getDistance function

module.exports = getDistance



