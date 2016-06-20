class LadderConfig < ActiveRecord::Base
  belongs_to :ladder

  validates :default_ranking, presence: true
  validates :hours_to_confirm, presence: true

  validate :invalid_when_is_default_and_has_ladder_id
  validate :invalid_when_is_not_default_and_without_ladder_id
  validate :invalid_with_not_existing_ladder_id




  private

  def invalid_with_not_existing_ladder_id
    if ladder_id
      unless ladder
        self.errors[:base] << "The given ladder does not exist"
      end
    end
  end

  def invalid_when_is_not_default_and_without_ladder_id
    if !is_default and !ladder_id
      self.errors[:base] << "Default config has to be default or belong to a ladder"
    end
  end

  def invalid_when_is_default_and_has_ladder_id
    if is_default and ladder_id
      self.errors[:base] << "Default config can not belong to any ladder"
    end
  end

end
