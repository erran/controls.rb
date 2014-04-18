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
      error = Controls.assets(
        'page.sort' => 'asdfghjkl'
      )

      expect(error).to be_kind_of(Controls::Error)
      expect(error.status).to eq('400')
      expect(error.message).to eq('Invalid sort parameter: asdfghjkl: ASC')
    end
  end

  context 'GET /api/assets/search?query=Windows' do
    it 'returns only assets with Windows assets' do
      asset_collection = Controls.asset_search('Windows')
      expect(asset_collection).not_to be_kind_of(Controls::Error)
      expect(asset_collection).to be_kind_of(Controls::AssetCollection)

      asset_collection.resources.map(&:operating_system).each do |operating_system|
        expect(operating_system).to match(/^windows/i)
      end
    end
  end

  context 'GET /api/guidance/enable-email-attachment-filtering/applicable_assets' do
    it 'returns a 400 Bad Request on a bad page.sort parameter' do
      error = Controls.applicable_assets(
        'enable-email-attachment-filtering',
        'page.sort' => 'asdfghjkl'
      )

      expect(error).to be_kind_of(Controls::Error)
      expect(error.status).to eq('400')
      expect(error.message).to eq('Invalid sort parameter: asdfghjkl: ASC')
    end
  end

  context 'GET /api/security_control/desktops-with-antivirus-deployed/uncovered_assets' do
    it 'returns a 400 Bad Request on a bad page.sort parameter' do
      error = Controls.uncovered_assets(
        'desktops-with-antivirus-deployed',
        'page.sort' => 'asdfghjkl'
      )

      expect(error).to be_kind_of(Controls::Error)
      expect(error.message).to eq('Invalid sort parameter: asdfghjkl: ASC')
      expect(error.status).to eq('400')
    end
  end

  context 'GET /api/threat_vectors/network-borne/undefended_assets' do
    it 'returns a 400 Bad Request on a bad page.sort parameter' do
      error = Controls.undefended_assets(
        'network-borne',
        'page.sort' => 'asdfghjkl'
      )

      expect(error).to be_kind_of(Controls::Error)
      expect(error.message).to eq('Invalid sort parameter: asdfghjkl: ASC')
      expect(error.status).to eq('400')
    end
  end
end
