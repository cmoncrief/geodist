var round, geodist, expect;

// Make it work in node..
try {
	geodist = require('../index.js');
	expect = require('expect.js');
	round = require('@yr/number-utils').round
// .. or browser
} catch (err) {
	geodist = require('geodist/index.js');
	expect = window.expect;
	round = require('@yr/number-utils#0.2.2').round;
}

describe('geodist', function () {
	describe('distance', function () {
		it('should calculate meters between Chicago and Atlanta', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			});
			expect(dist).to.eql(945086);
		});
		it('should calculate meters between Los Angeles and San Francisco', function () {
			var dist = geodist({
				lat: 34.0522,
				lon: -118.2428
			}, {
				lat: 37.7750,
				lon: -122.4183
			});
			expect(dist).to.eql(559116);
		});
		it('should calculate meters between Tokyo and Osaka', function () {
			var dist = geodist({
				lat: 35.6833,
				lon: 139.7667
			}, {
				lat: 34.6603,
				lon: 135.5232
			});
			expect(dist).to.eql(402092);
		});
		it('should calculate meters between Paris and Berlin', function () {
			var dist = geodist({
				lat: 48.8742,
				lon: 2.3470
			}, {
				lat: 52.5233,
				lon: 13.4127
			});
			expect(dist).to.eql(877379);
		});
	});

	describe('limits', function () {
		it('should return false if limit is exceeded', function () {
			var dist = geodist({
				lat: 35.6833,
				lon: 139.7667
			}, {
				lat: 34.6603,
				lon: 135.5232
			}, {
				limit: 321869
			});
			expect(dist).to.eql(false);
		});
		it('should return true if limit is exceeded', function () {
			var dist = geodist({
				lat: 35.6833,
				lon: 139.7667
			}, {
				lat: 34.6603,
				lon: 135.5232
			}, {
				limit: 402336
			});
			expect(dist).to.eql(true);
		});
	});

	describe('units', function () {
		it('should calculate miles between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'miles'
			});
			expect(dist).to.eql(11922);
		});
		it('should calculate mi between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'mi'
			});
			expect(dist).to.eql(11922);
		});
		it('should calculate yards between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'yards'
			});
			expect(dist).to.eql(20983263);
		});
		it('should calculate feet between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'feet'
			});
			expect(dist).to.eql(62949789);
		});
		it('should calculate km between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'km'
			});
			expect(dist).to.eql(19181);
		});
		it('should calculate kilometers between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'kilometers'
			});
			expect(dist).to.eql(19181);
		});
		it('should calculate meters between Cordoba and Hamilton', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'meters'
			});
			expect(dist).to.eql(19181067);
		});
		it('should calculate in meters when an invalid unit is set', function () {
			var dist = geodist({
				lat: 37.8833,
				lon: 4.7833
			}, {
				lat: -37.7833,
				lon: 175.2833
			}, {
				unit: 'foo'
			});
			expect(dist).to.eql(19181067);
		});
	});

	describe('output options', function () {
		it('should output whole numbers by default', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			});
			expect(dist).to.eql(945086);
		});
		it('should output decimal numbers when exact option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				exact: true
			});
			expect(round(dist, 4)).to.eql(945086.1705);
		});
		it('should output miles string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'miles'
			});
			expect(dist).to.eql('587 miles');
		});
		it('should output mi string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'mi'
			});
			expect(dist).to.eql('587 mi');
		});
		it('should output yards string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'yards'
			});
			expect(dist).to.eql('1033883 yards');
		});
		it('should output feet string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'feet'
			});
			expect(dist).to.eql('3101650 feet');
		});
		it('should output km string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'km'
			});
			expect(dist).to.eql('945 km');
		});
		it('should output kilometers string when format option is set', function () {
			var dist = geodist({
				lat: 41.85,
				lon: -87.65
			}, {
				lat: 33.7489,
				lon: -84.3881
			}, {
				format: true,
				unit: 'kilometers'
			});
			expect(dist).to.eql('945 kilometers');
		});
	});
});