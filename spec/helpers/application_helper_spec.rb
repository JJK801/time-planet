require "rails_helper"

describe ApplicationHelper do
  describe "#get_host_without_www" do
    it "strips protocol" do
      expect(helper.get_host_without_www('https://mon-cdi.fr')).to eq('mon-cdi.fr')
    end

    it "strips protocol and subdomain" do
      expect(helper.get_host_without_www('https://www.mon-cdi.fr')).to eq('mon-cdi.fr')
    end

    it "strips path" do
      expect(helper.get_host_without_www('https://www.mon-cdi.fr/home')).to eq('mon-cdi.fr')
    end

    it "returns nil when url is blank" do
      expect(helper.get_host_without_www('')).to eq(nil)
    end

    it "returns nil when url is nil" do
      expect(helper.get_host_without_www(nil)).to eq(nil)
    end
  end
end