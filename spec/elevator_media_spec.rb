require 'elevator_media'
require 'json'

RSpec.describe ElevatorMedia::Streamer do
    describe "getContent" do
        ## Check if the response is a string of JSON
        context "Check response JSON" do
            it "Returns a JSON" do
                expect(ElevatorMedia::Streamer.is_json?(ElevatorMedia::Streamer.api_call().body)).to eq(true)
            end
        end
        ## Check if the status is 200
        context "Check test response status" do
            it "Response status is 200" do
                expect(ElevatorMedia::Streamer.api_call().status).to eq(200)
            end
        end
        ## Check if the response include the substring "Yo mamma"
        context "Check Yo mamma" do
            it "Joke contains Yo mamma" do
                expect(ElevatorMedia::Streamer.get_joke()).to include("Yo mamma")
            end
        end
        ## Check if the getContent returns a string that includes a <div>
        context "Check HTML format" do
            it "Contains <div>" do
                expect(ElevatorMedia::Streamer.getContent()).to match(/<div>/)
            end
        end
    end
end