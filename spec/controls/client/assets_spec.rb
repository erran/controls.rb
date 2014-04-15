require_relative '../../spec_helper.rb'

describe '/api/assets' do
  before do
    login_to_environment
  end

  context 'GET /api/assets' do
    it 'returns a paginated asset collection' do
      assets = Controls.assets

      expect(assets).to be_kind_of(Controls::AssetCollection)
    end

    it 'respects pageable parameters' do
      asset_collection = Controls.assets(
        'page.sort' => 'os',
        'page.size' => 20,
        'page.sort.dir' => 'DESC'
      )
      expect(asset_collection).to be_kind_of(Controls::AssetCollection)

      sort = asset_collection.sort.first
      expect(sort.ascending?).to be_false
      expect(sort.direction).to eq('DESC')
      expect(sort.property).to eq('os')

      operating_systems = asset_collection.resources.map(&:operating_system)
      expect(operating_systems).to eq(operating_systems.sort.reverse)
    end

    it 'returns a 400 Bad Request on a bad page.sort parameter' do
      asset_collection = expect {
        Controls.assets(
          'page.sort' => 'asdfghjkl;'
        )
      }.not_to raise_error, "expected: 200 OK\ngot: 500 Internal Server Error"
      expect(asset_collection).to be_kind_of(Controls::Error)
    end
  end

  context 'GET /api/assets/search?query=Windows' do
    it 'returns only assets with Windows assets' do
      asset_collection = Controls.asset_search('Windows')
      expect(asset_collection).to be_kind_of(Controls::AssetCollection)

      asset_collection.resources.map(&:operating_system).each do |operating_system|
        expect(operating_system).to match(/^windows/i)
      end
    end
  end
end
