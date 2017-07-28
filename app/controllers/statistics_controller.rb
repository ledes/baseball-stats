class StatisticsController < ApplicationController
  DEFAULT_SEASON = 1998
  DEFAULT_SORT_ORDER = 'DESC'
  DEFAULT_SORT_BY = 'avg'
  STATS_PER_PAGE = 25

  def index
    statistics = get_statistics(DEFAULT_SORT_BY, DEFAULT_SORT_ORDER, DEFAULT_SEASON)
    @data = { sort_by: DEFAULT_SORT_BY,
              sort_order: DEFAULT_SORT_ORDER,
              seasons: [DEFAULT_SEASON],
              is_last_page: is_last_page(statistics),
              statistics: statistics }
  end

  def index_with_sort
    statistics = get_statistics(params['sort_by'], params['sort_order'], params['season'], params['page'].to_i)
    render json: { statistics: statistics, is_last_page: is_last_page(statistics) }
  end

  def is_last_page(statistics)
    statistics.length < STATS_PER_PAGE
  end

  def get_statistics(sorting_colum, sort_order, season, page = 1)
    offset = STATS_PER_PAGE * (page - 1)
    sql = %{
      SELECT s.id, s.avg, s.home_runs, s.rbi, s.runs,
             s.sb, s.ops, h.name, h.given_name, h.position
      FROM statistics as s
      INNER JOIN players AS h
      ON h.id = s.player_id
      WHERE h.type = 'Hitter' AND s.season=#{season}
      ORDER BY #{sorting_colum} #{sort_order} LIMIT #{STATS_PER_PAGE} OFFSET #{offset};
    }
    ActiveRecord::Base.connection.execute(sql).to_a
  end

end
