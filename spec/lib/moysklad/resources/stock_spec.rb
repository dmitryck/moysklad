require 'spec_helper'

describe Moysklad::Resources::Stock do
  it 'should be loaded' do
    expect(Moysklad::Resources::Stock).to be_a Class
  end

  let(:resource) { Moysklad::Resources::Stock.new client: client }

  describe do
    it 'should get list' do
      expect(resource.send(:list_path)).to  eq "exchange/rest/stock/xml"
    end
  end

  describe 'listWithConsignments' do
    subject { resource.listWithConsignments }
    before do
      stub_stock_rest_with_consignments
    end
    it do
      expect(subject.count).to eq 879
    end

    context 'stock item' do
      subject { resource.listWithConsignments.first }

      it do
        expect(subject).to be_a Moysklad::Entities::StockTO
      end

      it do
        expect(subject.consignmentName).to_not be_empty
      end

      it do
        expect(subject.consignmentUuid).to_not be_empty
      end
    end
  end

  describe 'collection' do

    before do
      stub_stock_rest
    end

    subject { resource.collection }

    it do
      expect(subject.count).to eq 516
    end

  end
end
