"use strict";

var Pagination = React.createClass({

  propTypes: {
    handleChangePage: React.PropTypes.func.isRequired,
    currentPage: React.PropTypes.number.isRequired,
    isLastPage: React.PropTypes.bool.isRequired
  },


  render: function() {
    var previousPage = this.props.currentPage - 1;
    var nextPage = this.props.currentPage + 1;
    var previousPageAction = previousPage > 0 ? this.props.handleChangePage.bind(null, previousPage) : null;
    var nextPageAction = this.props.isLastPage ? null : this.props.handleChangePage.bind(null, nextPage);

    var previousLink = (
      <li className={"page-item " + (previousPage > 0 ? '' : 'disabled')}>
        <a className="page-link" onClick={previousPageAction}>Previous</a>
      </li>
    );
    var nextLink = (
      <li className={"page-item " + (this.props.isLastPage ? 'disabled' : '')}>
        <a className="page-link" onClick={nextPageAction}>Next</a>
      </li>
    );

    return (
      <div className='pagination-component'>
        <nav aria-label="Page navigation example">
          <ul className="pagination">
            {previousLink}
            <li className="page-item active"><a className="page-link">{this.props.currentPage}</a></li>
            {nextLink}
          </ul>
        </nav>
      </div>
    );
  }
});
