require 'aws-sdk'

class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name        , type: String
  field :bucket_name , type: String
  field :title       , type: String
  field :description , type: String

  default_scope order_by([[:updated_at, :asc]])

  def download_url
    bucket = s3.buckets[bucket_name]
    object = bucket.objects[name]
    url = object.url_for(:read, response_content_disposition: %Q(attachment; filename="#{name}"))
    url.to_s
  end

  private

  def s3
    @s3 ||= AWS::S3.new(access_key_id: '02D3VGN7JVANFEQ6MBR2',
                        secret_access_key: 'o0txy9yrCyWTeHXxtcy2lNKoXohHJ+oZ2QUVrvRV')
  end

  def content_disposition
    value = %Q(attachment; filename="#{name}")
    # "response-content-disposition=#{URI.escape(value)}"
    "response-content-disposition=#{value}"
  end
end
