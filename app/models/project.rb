class Project < ApplicationRecord
  include PublicActivity::Common
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Constants
  SETTINGS = %i(slug scale unit color_format)

  # Relations
  has_many :users
  has_one :team, dependent: :destroy
  has_one :styleguide, dependent: :destroy
  has_many :artboards, dependent: :destroy
  has_many :slices, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :artboards

  # Validations
  # validates_uniqueness_of :name
  validates :name, presence: true

  # Callbacks
  before_save :set_thumb
  after_create :create_styleguide

  # Scopes
  default_scope { order(created_at: :desc) }
  default_scope { where(archived: false) }
  scope :archived, -> { where(archived: true) }

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
    existing_records = filter_existing_records!(artboards_data, artboards)

    artboards.create(artboards_data) if artboards_data.present?

    Artboard.update(existing_records.keys, existing_records.values) if existing_records.present?
  end

  def add_or_update_slices(slices_data)
    existing_records = filter_existing_records!(slices_data, slices)

    slices.create(slices_data) if slices_data.present?

    Slice.update(existing_records.keys, existing_records.values) if existing_records.present?
  end

  def team_id
    team.id
  end

  # FIXME: This is not working yet!
  def update_thumb!
    self.thumb = artboards.first.artboard_thumb

    save
  end

  def set_due_date(date)
    due_date ? (self.due_date = date if due_date > date) : self.due_date = date

    save
  end

  def archive!
    archived = true

    save
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
  def filter_existing_records!(records, rel)
    existing_records = rel.where(object_id: object_id_array(records))

    return nil unless existing_records.present?

    # Get record IDs to map it with the resulting hash
    record_ids = existing_records.map(&:id)
    object_ids = object_id_array(existing_records)

    existing_records =
      records.map { |record| records.delete(record) if record[:object_id].in?(object_ids) }.compact

    format_existing_records(existing_records, record_ids)
  end

  # Returns a hash like { id: { record } }
  def format_existing_records(existing_records, record_ids)
    existing_records.each_with_index.with_object({}) do |(record, index), hash|
      hash[record_ids[index]] = record
    end
  end

  def object_id_array(data)
    data.map { |record| record[:object_id] }
  end

  def set_thumb
    return if thumb || artboards_count == 0

    self.thumb = artboards.first.artboard_thumb
  end

  def create_styleguide
    Styleguide.create(project_id: id)
  end
end
