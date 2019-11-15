require "rails_helper"

describe ApplicationHelper do
  describe "#get_host_without_www" do
    it "strips protocol" do
      helper.get_host_without_www('https://mon-cdi.fr').should eq('mon-cdi.fr')
    end

    it "strips protocol and subdomain" do
      helper.get_host_without_www('https://www.mon-cdi.fr').should eq('mon-cdi.fr')
    end

    it "strips path" do
      helper.get_host_without_www('https://www.mon-cdi.fr/home').should eq('mon-cdi.fr')
    end

    it "returns nil when url is blank" do
      helper.get_host_without_www('').should eq(nil)
    end

    it "returns nil when url is nil" do
      helper.get_host_without_www(nil).should eq(nil)
    end
  end
end