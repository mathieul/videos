require 'aws'

class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name        , type: String
  field :title       , type: String
  field :description , type: String
  field :url         , type: String

  default_scope order_by([[:updated_at, :asc]])

  def download_url
    content_disposition = %Q(attachment; filename="#{name}")
    "#{signed_url}&response-content-disposition=#{URI.escape(content_disposition)}"
  end

  private

  def signed_url
    s3 = Aws::S3.new('02D3VGN7JVANFEQ6MBR2', 'o0txy9yrCyWTeHXxtcy2lNKoXohHJ+oZ2QUVrvRV')
    bucket_gen = Aws::S3Generator::Bucket.create(s3, 'zlaj-sharing')
    path = URI.parse(url).path[1..-1]
    bucket_gen.get(URI.unescape(path))
  end
end
