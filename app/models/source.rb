class Source < ActiveRecord::Base
  set_primary_key :source_id

  belongs_to :paper

  validates_format_of :md5, :with => /\A[0-9a-f]{32}\z/
  validates_format_of :filetype, :with => /\A[a-z]{2,}\z/

  after_save :upload_object

  def self.build_from_data(filetype, data)
    filetype = filetype.downcase
    md5 = Digest::MD5.hexdigest(data)
    scoped.find_or_initialize_by_filetype_and_md5(filetype, md5, :data => data)
  end

  def data=(content)
    self.size = content.bytesize
    self.md5 = Digest::MD5.hexdigest(content)
    @content = content
  end

  def mimetype
    case filetype
    when 'pdf' then 'application/pdf'
    else raise "unknown filetype: #{filetype}"
    end
  end

  def upload_object
    return unless @content
    obj = s3_object
    obj.content = @content
    obj.content_type = mimetype
    obj.save
  end

  def s3_url
    s3_object.url
  end

  def s3_bucket
    # TODO: centralize configuration
    S3::Service.new(
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET'],
    ).bucket(ENV['S3_BUCKET'])
  end

  def s3_object
    s3_bucket.object("#{md5}.#{filetype}")
  end
end
