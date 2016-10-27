class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Constants
  SETTINGS = %i(slug scale unit color_format)

  # Relations
  has_many :users
  has_one :team, dependent: :destroy
  has_many :artboards
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :artboards

  # Validations
  # validates_uniqueness_of :name

  # Callbacks
  before_save :set_thumb

  def slug_candidates
    [
      :name,
      [:name, :platform],
      [:name, :platform, :scale],
      [:name, :platform, :scale, :unit],
      [:name, :platform, :scale, :unit, :color_format],
      [:name, :platform, :scale, :unit, :color_format, :id],
    ]
  end

  def update_settings(project_settings)
    return if settings_match?(project_settings)

    self.slug         = project_settings[:slug]
    self.scale        = project_settings[:scale]
    self.unit         = project_settings[:unit]
    self.color_format = project_settings[:color_format]

    save
  end

  def add_or_update_artboards(artboards_data)
    existing_artboards = filter_existing_artboards!(artboards_data)

    artboards.create(artboards_data) if artboards_data.present?

    Artboard.update(existing_artboards.keys, existing_artboards.values) if existing_artboards.present?
  end

  private

  def settings_match?(project_settings)
    return false if slug         != project_settings[:slug]
    return false if scale        != project_settings[:scale]
    return false if unit         != project_settings[:unit]
    return false if color_format != project_settings[:color_format]

    true
  end

  # Filter artboards data to remove existing records,
  # and return them in a seperate array
  def filter_existing_artboards!(artboards_data)
    existing_artboards = Artboard.where(
      object_id: oid_array(artboards_data),
      project_id: id
    )

    return nil unless existing_artboards.present?

    # Get artboard ids to map it with the resulting hash
    artboards_ids = existing_artboards.map(&:id)

    existing_artboards =
      artboards_data.map { |artboard| artboards_data.delete(artboard) if artboard[:object_id].in?(oid_array(existing_artboards)) }.compact

    format_existing_artboards(existing_artboards, artboards_ids)
  end

  # Returns a hash like { id: { artboard } }
  def format_existing_artboards(existing_artboards, artboards_ids)
    existing_artboards.each_with_index.with_object({}) do |(artboard, index), hash|
      hash[artboards_ids[index]] = artboard
    end
  end

  def oid_array(data)
    data.map { |artboard| artboard[:object_id] }
  end

  def set_thumb
    return unless artboards_count == 1

    self.thumb = artboards.first.artboard_thumb
  end
end
