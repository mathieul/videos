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
    object = s3.buckets[bucket_name].objects[name]
    url = object.url_for(:read, response_content_disposition: %Q(attachment; filename="#{name}"))
    url.to_s
  end

  private

  def s3
    @s3 ||= AWS::S3.new(access_key_id:      APP_CONFIG[:access_key_id],
                        secret_access_key:  APP_CONFIG[:secret_access_key])
  end
end
