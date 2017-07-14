#!/usr/bin/env ruby

require 'time'
require 'uri'
require 'openssl'
require 'base64'
require 'rest-client'
require 'httparty'
require 'pry'
require 'yaml'

require_relative '../lib/products'
require_relative '../lib/amazon-api'

KEYS = YAML.load_file('application.yml')

