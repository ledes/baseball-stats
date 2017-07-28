var StatisticsApp = React.createClass({

  propTypes: {
    data: React.PropTypes.shape({
      statistics: React.PropTypes.arrayOf(React.PropTypes.object).isRequired,
      seasons: React.PropTypes.arrayOf(React.PropTypes.number).isRequired,
      sort_by: React.PropTypes.string.isRequired,
      sort_order: React.PropTypes.string.isRequired,
      is_last_page: React.PropTypes.bool.isRequired
    })
  },

  getInitialState: function() {
    return {
      statistics: this.props.data.statistics,
      season: this.props.data.seasons[0],
      sortBy: this.props.data.sort_by,
      sortOrder: this.props.data.sort_order,
      page: 1,
      isLastPage: this.props.data.is_last_page,
    };
  },

  // Actions

  onPageChanged: function(page) {
    var state = this.state;
    $.when(this.sortStatistics(state.sortOrder, state.sortBy, page)).then(function() {
      this.setState({page: page});
    });
  },

  onChangeSeason: function(e) {
    var selectedSeason = e.target.value;
    //TODO implement for other seasons
  },

  sortStatistics: function(sortOrder, sortBy, page) {
    page = page || this.state.page;
    var url = 'api/v1/statistics';
    var season = _.clone(this.state.season);
    var params = {
      season: season,
      sort_order: sortOrder,
      sort_by: sortBy,
      page: page
    };

    return $.ajax({
      url: url,
      type: 'GET',
      context: this,
      data: params,
      contentType: 'application/json',
      success: function(data) {
        this.setState({
          statistics: data.statistics,
          sortBy: params['sort_by'],
          sortOrder: params['sort_order'],
          isLastPage: data.is_last_page
        });
      },
      error: function (error) {
        console.log(error);
      }
    })
  },

  // Render

  rendernav: function() {
    var seasonOptions = _.map(this.props.data.seasons, function(season) {
      return ( <option key={'season-' + season}>{season}</option> );
    });
    return (
      <div className='nav'>
        <div className='title'>
          <h1>Baseball Stats</h1>
        </div>
        <div className={'season-selector'}>
          <h5>Select a season</h5>
          <select className="selectpicker"
                      defaultValue={this.state.season}
                      onChange={this.onChangeSeason}>
            {seasonOptions}
          </select>
        </div>
      </div>
    );
  },

  render: function() {
    return (
      <div id='statisticsApp'>
        {this.rendernav()}
        <Pagination
          handleChangePage={this.onPageChanged}
          currentPage={this.state.page}
          isLastPage={this.state.isLastPage}/>
        <SortableTable
          data={this.state.statistics}
          keyFn={function(statistic) {return statistic.id}}
          columns={Blobs.TableColumns}
          sortBy={this.state.sortBy}
          sortDescending={this.state.sortOrder === 'DESC'}
          onSort={this.sortStatistics}/>
      </div>
    );
  }
});
