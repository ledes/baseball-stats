class Statistic < ApplicationRecord
  belongs_to :player
  before_save :add_extra_params

  validates :season, presence: true
  validates :at_bats, presence: true
  validates :hits, presence: true
  validates :doubles, presence: true
  validates :triples, presence: true
  validates :home_runs, presence: true
  validates :sb, presence: true
  validates :rbi, presence: true
  validates :walks, presence: true
  validates :hit_by_pitch, presence: true
  validates :sacrifice_flies, presence: true


  def add_extra_params
    self.avg = generate_avg
    self.ops = generate_ops
  end

  # AVG = Hits / at_bats
  def generate_avg
    if self.at_bats > 0
      avg = (self.hits.to_f / self.at_bats.to_f)
      "%0.3f" % avg
    else
      '0.000'
    end
  end

  # OPS = OPB + SLG
  def generate_ops
    obs = (generate_obp + generate_slg).round(3)
    "%0.3f" % obs
  end

  # (hits + walks + times_hit_by_pitch) /
  # (at_bats + walks + sacrifice_flies + times_hit_by_pitch)
  def generate_obp
    denominator = (self.at_bats + self.walks + self.sacrifice_flies + self.hit_by_pitch).to_f
    if denominator > 0
      ((self.hits + self.walks + self.hit_by_pitch).to_f / denominator).round(3)
    else
      0.000
    end
  end

  # SLG = (singles + (doubles x 2) + (triples x 2) + (home runs x4 )) / at bats
  def generate_slg
    if self.at_bats > 0
      ((singles +
       (self.doubles * 2) +
       (self.triples * 3) +
       (self.home_runs * 4)).to_f / self.at_bats.to_f).round(3)
     else
       0.000
     end
  end

  def singles
    self.hits - self.doubles - self.triples - self.home_runs
  end
end
