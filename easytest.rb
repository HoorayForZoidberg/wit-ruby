require "dotenv"
require "json"
require "ibm_watson/authenticators"
require "ibm_watson/tone_analyzer_v3"
include IBMWatson

Dotenv.load('secrets.env')

authenticator = Authenticators::IamAuthenticator.new(
  apikey: ENV['IBM_Watson_API']
)
tone_analyzer = ToneAnalyzerV3.new(
  version: "2017-09-21",
  authenticator: authenticator
)
tone_analyzer.service_url = "https://api.us-east.tone-analyzer.watson.cloud.ibm.com/instances/911a49b7-ea48-4412-b638-4bfba4c937c9"

text = gets.chomp

tone = tone_analyzer.tone(
  tone_input: {text: text},
  content_type: "application/json"
)

puts JSON.pretty_generate(tone.result)
