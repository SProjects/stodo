require File.expand_path '../spec_helper.rb', __FILE__
describe "Blog" do

    it "renders homepage with success" do
        get("/")
        expect(last_response).to be_ok
    end
end
