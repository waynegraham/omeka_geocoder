require "omeka_geocoder/version"

require 'csv'
require 'geocoder'
require 'optparse'
require 'ostruct'

module OmekaGeocoder

  class OptionsParser
    def self.parse(args)
      options = OpenStruct.new
      options.verbose = false

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: omeka_geocoder [options] path/to/addresses.csv"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-v", "--[no]-verbose", "Run verbosely") do |v|
          options.verbose = v
        end

        opts.separator ""

        opts.separator "Common options:"
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end

  class CLI

    attr_accessor :file

    def initialize(*args)
      if(File.file?(args[0][0]))
        @file = args[0][0]
        @csv = CSV.read(@file, { headers: true })
      end
    end

    def geocode

      @csv.each do |line|
        address = make_address(line)
        result = Geocoder.search(address).first

        projected = degrees_to_meters(
          result.longitude,
          result.latitude
        )
        puts projected['longitude']
      end
    end

    def make_address(line)
      "#{line['Address']}, #{line['City']}, #{line['State']}"
    end

    def degrees_to_meters(lon, lat)
      half_circumference = 20037508.34
      x = lon * half_circumference / 180
      y = Math.log(Math.tan((90 + lat) * Math::PI / 360)) / (Math::PI / 180)
      y = y * half_circumference / 180
      return {"latitude" => x, "longitude" => y}
    end

    def run
      geocode
    end
  end
end
