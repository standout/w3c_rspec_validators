require "w3c_rspec_validators"

describe "css_files" do
  describe "self.compiled" do
  
    before(:each) do
      Object.should_receive(:system).with "rake -q assets:precompile"
      Rails.stub(:root).and_return "railsroot"
      FileUtils.should_receive(:rm_rf).with "railsroot/public/assets/"
    end

    it "should read css files from a directory" do
      directory = File.dirname(__FILE__)
      W3cRspecValidators::CssFiles.compiled(["#{directory}/fixtures/*.css"])
        .should == "#home {}\nbody {\n}\n"
    end
  end
end
