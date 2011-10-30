require 'aws'

class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name        , type: String
  field :bucket_name , type: String
  field :title       , type: String
  field :description , type: String

  default_scope order_by([[:updated_at, :asc]])

  def download_url
    bucket_gen = Aws::S3Generator::Bucket.create(s3, bucket_name)
    path = "#{name}?#{content_disposition}"
    bucket_gen.get(path)
  end

  private

  def s3
    @s3 ||= Aws::S3.new('02D3VGN7JVANFEQ6MBR2', 'o0txy9yrCyWTeHXxtcy2lNKoXohHJ+oZ2QUVrvRV')
  end

  def content_disposition
    value = %Q(attachment; filename="#{name}")
    # "response-content-disposition=#{URI.escape(value)}"
    "response-content-disposition=#{value}"
  end
end
