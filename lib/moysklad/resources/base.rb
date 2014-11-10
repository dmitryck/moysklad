class Moysklad::Resources::Base
  PREFIX_PATH = 'exchange/rest/ms/xml/'

  # https://support.moysklad.ru/hc/ru/articles/203404253-REST-сервис-синхронизации-данных
  def initialize client: nil
    raise "Должен быть Moysklad::Client" unless client.is_a? Moysklad::Client
    @client = client
  end

  def list params={}
    parse client.get list_path, params
  end

  def find uuid
    parse client.get item_path uuid
  end

  def create resource
    parse client.put create_path, prepare_resource(resource)
  end

  def delete uuid
    client.delete item_path uuid 
  end

  private

  attr_reader :client

  def prepare_resource resource
    if resource.is_a? Moysklad::Entities::Base
      resource.to_xml(Nokogiri::XML::Builder.new(encoding: 'utf-8')).to_xml 
    else
      resource
    end
  end

  def parse content
    entity_class.parse content
  end

  def item_path uuid
    prefix_path + '/' + uuid
  end

  def create_path
    prefix_path
  end

  def list_path
    prefix_path + '/list'
  end

  def prefix_path
    PREFIX_PATH + type
  end

  def type
    self.class.name.split('::').last
  end

  def entity_class
    "Moysklad::Entities::#{type}".constantize
  end
end