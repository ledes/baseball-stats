
xml_file = File.read("#{Rails.root}/db/1998statistics.xml")
doc = Nokogiri::XML.parse(xml_file)

season = doc.xpath('//SEASON//YEAR').children[0].content.to_i

doc.xpath('SEASON/LEAGUE').each do |league|
  league.xpath('DIVISION').each do |division|
    division.xpath('TEAM').each do |team|
      team.xpath('PLAYER').each do |player|
        attributes = {}
        player.children.map do |attribute|
          attributes[attribute.name.downcase] = attribute.content
        end
        if attributes['hits'] # if hits exists the player is a hitter
          hitter = Hitter.create!(
            name: attributes['surname'],
            given_name: attributes['given_name'],
            position: attributes['position']
          )
          Statistic.create!(
            player: hitter,
            season: season,
            games: attributes['games'].to_i,
            games_started: attributes['games_started'].to_i,
            at_bats: attributes['at_bats'].to_i,
            runs: attributes['runs'].to_i,
            hits: attributes['hits'].to_i,
            doubles: attributes['doubles'].to_i,
            triples: attributes['triples'].to_i,
            home_runs: attributes['home_runs'].to_i,
            rbi: attributes['rbi'].to_i,
            sb: attributes['steals'].to_i,
            caught_stealing: attributes['caught_stealing'].to_i,
            sacrifice_hits: attributes['sacrifice_hits'].to_i,
            sacrifice_flies: attributes['sacrifice_flies'].to_i,
            player_errors: attributes['player_errors'].to_i,
            pb: attributes['pb'].to_i,
            walks: attributes['walks'].to_i,
            struck_out: attributes['struck_out'].to_i,
            hit_by_pitch: attributes['hit_by_pitch'].to_i,
          )
        end
      end
    end
  end
end
