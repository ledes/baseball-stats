require 'rails_helper'

RSpec.describe Statistic, type: :model do
  it { should belong_to(:player) }

  it { should validate_presence_of :season }
  it { should validate_presence_of :at_bats }
  it { should validate_presence_of :hits }
  it { should validate_presence_of :doubles }
  it { should validate_presence_of :triples }
  it { should validate_presence_of :home_runs }
  it { should validate_presence_of :sb }
  it { should validate_presence_of :rbi }
  it { should validate_presence_of :walks }
  it { should validate_presence_of :hit_by_pitch }
  it { should validate_presence_of :sacrifice_flies }

  let!(:player) do
    Hitter.create(
      name: "Lockhart",
      given_name: "Keith",
      position: "Second Base"
    )
  end

  let!(:statistic) do
    Statistic.new(
      player: player,
      season: 1998,
      at_bats: 366,
      hits: 94,
      doubles: 21,
      triples: 0,
      home_runs: 9,
      sb: 2,
      caught_stealing: 2,
      sacrifice_flies: 3,
      walks: 29,
      hit_by_pitch: 1,
    )
   end

  describe "generate_avg" do
    scenario "it should return the right avg" do
      expect(statistic.generate_avg).to eq('0.257')
    end
    scenario "it retuns 0.000 if the division is not possible" do
      statistic.at_bats = 0
      expect(statistic.generate_avg).to eq('0.000')
    end
  end

  describe "generate_ops" do
    scenario "it should return the right ops" do
      expect(statistic.generate_ops).to eq('0.699')
    end
  end

  describe "generate_obp" do
    scenario "it should return the right obp" do
      expect(statistic.generate_obp).to eq(0.311)
    end
    scenario "it retuns 0.000 if the division is not possible" do
      statistic.at_bats = statistic.walks = statistic.sacrifice_flies = statistic.hit_by_pitch = 0
      expect(statistic.generate_obp).to eq(0.000)
    end
  end

  describe "generate_slg" do
    scenario "it should return the right obp" do
      expect(statistic.generate_slg).to eq(0.388)
    end
    scenario "it retuns 0.000 if the division is not possible" do
      statistic.at_bats = 0
      expect(statistic.generate_slg).to eq(0.000)
    end
  end

  describe "singles" do
    scenario "it should return the amount of singles" do
      expect(statistic.singles).to eq(64)
    end
  end
end
