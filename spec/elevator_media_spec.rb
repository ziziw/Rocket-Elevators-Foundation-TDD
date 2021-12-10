require 'elevator_media'
require 'json'

RSpec.describe ElevatorMedia::Streamer do
    describe "getContent" do
        context "Check response JSON" do
            it "Returns a JSON" do
                expect(ElevatorMedia::Streamer.is_json?(ElevatorMedia::Streamer.api_call().body)).to eq(true)
            end
        end
        context "Check test response status" do
            it "Response status is 200" do
                expect(ElevatorMedia::Streamer.api_call().status).to eq(200)
            end
        end
        context "Check Yo mama" do
            it "Joke contains Yo mama" do
                expect(ElevatorMedia::Streamer.get_joke()).to include("Yo mamma")
            end
        end
        context "Check HTML format" do
            it "Contains <DIV>" do
                expect(ElevatorMedia::Streamer.getContent()).to match(/<div>/)
            end
        end
    end
end