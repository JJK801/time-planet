require 'rails_helper'

describe UpdatePrismicContentsJob do
  before(:all) do
    @prismic_api_url = 'https://time-planet.cdn.prismic.io/api'
    @prismic_api_search_url = 'https://time-planet.cdn.prismic.io/api/v1/documents/search'
    @first_call_response_body = open(Rails.root.join('spec/mocks/prismic/first_call_response_body.json')).read
    @projects_body = open(Rails.root.join('spec/mocks/prismic/projects_mock.json')).read
    @entrepreneurs_body = open(Rails.root.join('spec/mocks/prismic/entrepreneurs_mock.json')).read
  end

  context 'for projects' do
    before(:each) do
      # Prismic does a first request on 'https://time-planet.cdn.prismic.io/api'
      # Then following requests on 'https://time-planet.cdn.prismic.io/api/v1/documents/search'
      stub_request(:get, /^(?!.*search).*#{Regexp.quote(@prismic_api_url)}.*$/).to_return(
        { status: 200, body: @first_call_response_body })
      stub_request(:get, /#{Regexp.quote(@prismic_api_search_url)}/).to_return({ status: 200, body: @projects_body })
    end

    it 'creates a project in db when not already present' do
      UpdatePrismicContentsJob.perform_now('Project')

      expect(Project.all.count).to eq(1)
      expect(Project.first.prismic_id).to eq('fake_prismic_id')
      expect(Project.first.slug).to eq('fake-slug')
      expect(Project.first.title).to eq('Mon CDI')
      expect(Project.first.meta_title).to eq('La déprécarisation des personnes en intérim ou en CDD')
      expect(Project.first.meta_description).to eq('Fake meta description')
      expect(Project.first.project_url).to eq('https://www.mon-cdi.fr')
      expect(Project.first.funding_status).to eq('funding')
      expect(Project.first.long_summary).to eq('A long summary')
      expect(Project.first.short_summary).to eq('A short summary')
      expect(Project.first.description).to eq("<h1>Naissance du projet</h1>\n\n<p>Lorem ipsum</p>")
      expect(Project.first.quote).to eq('Vive le CDI')
      expect(Project.first.cover_image_url).to eq('https://fake-url')
      expect(Project.first.cover_image_alt).to eq('Alternative text of cover image')
      expect(Project.first.keyword_1).to eq('Social')
      expect(Project.first.icon_1).to eq('thumb_up_alt')
      expect(Project.first.published).to be true
    end

    it 'updates an project when it is already present in db' do
      prismic_id = JSON.parse(@projects_body)['results'].first['id']
      initial_project = FactoryBot.create(:project, prismic_id: prismic_id)

      UpdatePrismicContentsJob.perform_now('Project')

      expect(Project.first.title).not_to eq(initial_project.title)
    end

    it 'updates published status to false when project is present in db but not in prismic response' do
      prismic_id = 'id-not-present-in-prismic-response'
      FactoryBot.create(:project, prismic_id: prismic_id, published: true)

      UpdatePrismicContentsJob.perform_now('Project')

      expect(Project.find_by(prismic_id: prismic_id).published).to eq(false)
    end

    it 'does not set published to false even when an article is unchanged' do
      UpdatePrismicContentsJob.perform_now('Project')

      UpdatePrismicContentsJob.perform_now('Project')

      expect(Project.first.published).to eq(true)
    end

    it "makes more than one request when all articles don't fit in first page" do
      fake_client = double()
      allow(Prismic::Client).to receive(:new).and_return(fake_client)
      prismic_response = double();
      allow(prismic_response).to receive(:results).and_return([])
      allow(prismic_response).to receive(:next_page).and_return('http://next-page-url', nil)
      allow(fake_client).to receive(:projects).and_return(prismic_response)

      UpdatePrismicContentsJob.perform_now('Project')

      expect(fake_client).to have_received(:projects).twice
      expect(fake_client).to have_received(:projects).with(1)
      expect(fake_client).to have_received(:projects).with(2)
    end
  end

  context 'for entrepreneurs' do
    before(:each) do
      # Prismic does a first request on 'https://time-planet.cdn.prismic.io/api'
      # Then other requests on 'https://time-planet.cdn.prismic.io/api/v1/documents/search'
      stub_request(:get, /^(?!.*search).*#{Regexp.quote(@prismic_api_url)}.*$/).to_return(
        { status: 200, body: @first_call_response_body })
      stub_request(:get, /#{Regexp.quote(@prismic_api_search_url)}/).to_return(
        { status: 200, body: @entrepreneurs_body })
    end

    it 'creates an entrepreneur in db when not already present' do
      project = FactoryBot.create(:project, prismic_id: 'fake_prismic_id')

      UpdatePrismicContentsJob.perform_now('Entrepreneur')

      expect(Entrepreneur.all.count).to eq(1)
      expect(Entrepreneur.first.prismic_id).to eq('fake_prismic_entrepreneur_id')
      expect(Entrepreneur.first.name).to eq('Philippe Bazin')
      expect(Entrepreneur.first.position).to eq('CEO')
      expect(Entrepreneur.first.description).to eq('A catchy description')
      expect(Entrepreneur.first.picture_url).to eq('https://fake-picture-url')
      expect(Entrepreneur.first.picture_alt).to eq('Portrait de Philippe')
      expect(Entrepreneur.first.project_id).to eq(project.id)
      expect(Entrepreneur.first.published).to be true
    end

    it 'updates an entrepreneur when it is already present in db' do
      json_entrepreneur = JSON.parse(@entrepreneurs_body)['results'].first
      project_prismic_id = json_entrepreneur['data']['entrepreneur']['project']['value']['document']['id']
      prismic_id =  json_entrepreneur['id']
      project = FactoryBot.create(:project, prismic_id: project_prismic_id)
      initial_entrepreneur = FactoryBot.create(:entrepreneur, prismic_id: prismic_id, project_id: project.id)

      UpdatePrismicContentsJob.perform_now('Entrepreneur')

      expect(Entrepreneur.first.name).not_to eq(initial_entrepreneur.name)
    end

    it 'updates published status to false when entrepreneur is present in db but not in prismic response' do
      prismic_id = 'id-not-present-in-prismic-response'
      FactoryBot.create(:entrepreneur, prismic_id: prismic_id, published: true)

      UpdatePrismicContentsJob.perform_now('Entrepreneur')

      expect(Entrepreneur.find_by(prismic_id: prismic_id).published).to eq(false)
    end

    it "makes more than one request when all entrepreneurs don't fit in first page" do
      fake_client = double()
      allow(Prismic::Client).to receive(:new).and_return(fake_client)
      prismic_response = double()
      allow(prismic_response).to receive(:results).and_return([])
      allow(prismic_response).to receive(:next_page).and_return('http://next-page-url', nil)
      allow(fake_client).to receive(:entrepreneurs).and_return(prismic_response)

      UpdatePrismicContentsJob.perform_now('Entrepreneur')

      expect(fake_client).to have_received(:entrepreneurs).twice
      expect(fake_client).to have_received(:entrepreneurs).with(1)
      expect(fake_client).to have_received(:entrepreneurs).with(2)
    end
  end
end
