class ExportableDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = object.as_json(except: %i(file_file_name file_content_type file_file_size file_updated_at))

    ret[:path]  = file.url(:thumb)

    ret
  end
end

