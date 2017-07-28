"use strict";
// Note: I made a completely reusable component to be used for more features
// in this platform or other projects

var SortableTable = React.createClass({

  // Props

  propTypes: {
    data: React.PropTypes.arrayOf(React.PropTypes.object).isRequired,
    keyFn: React.PropTypes.func.isRequired,
    columns: React.PropTypes.arrayOf(
      React.PropTypes.shape({
        header: React.PropTypes.string.isRequired,
        metric: React.PropTypes.string.isRequired,
        renderCell: React.PropTypes.func.isRequired,
        sortable: React.PropTypes.bool,
      })
    ).isRequired,
    sortBy: React.PropTypes.string.isRequired,
    sortDescending: React.PropTypes.bool.isRequired,
    onSort: React.PropTypes.func.isRequired
  },

  // Actions

  changeSort: function(column) {
    var sortOrder, sortBy;
    // if click on already selected column change order
    if (column.metric === this.props.sortBy) {
      sortOrder = this.props.sortDescending ? 'ASC': 'DESC';
      sortBy = this.props.sortBy;
    } else {
      // if click on different column sort DESC
      sortOrder = 'DESC';
      sortBy = column.metric;
    }
     this.props.onSort(sortOrder, sortBy);
  },

  // Render

  render: function() {
    return (
      <table className="table sortable-table">
        <colgroup>{this.props.columns.map(this.renderCol)}</colgroup>
        <thead><tr>{this.props.columns.map(this.renderHeaderCell)}</tr></thead>
        <tbody>{this.props.data.map(this.renderRow)}</tbody>
      </table>
    );
  },

  renderCol: function(column, idx) {
    return (<col key={idx} />);
  },

  renderHeaderCell: function(column, idx) {
    if (!column.sortable) {
      return (<th key={idx}>{column.header}</th>);
    }
    var className = "sortable ";
    if (column.nonNumeric) {
      className += "non-numeric ";
    } else {
      className += "numeric ";
    }
    if (column.metric === this.props.sortBy) {
      className += this.props.sortDescending ? "sorted-desc" : "sorted-asc";
    }

    return (
      <th className={className} onClick={this.changeSort.bind(null, column)} key={idx}>
        {column.header} <span className="sortable-table-icon glyphicon" />
      </th>
    );
  },

  renderRow: function(row, rowIdx) {
     var that = this;
     var avatar = (<i className="fa fa-user-circle" aria-hidden="true"></i>);
     return (
       <tr key={this.props.keyFn(row)}>
         {_.map(this.props.columns, function(column, columnIdx) {
           return (
             <td key={columnIdx}>
               {column.metric === 'name' ? avatar : ''}
               {column.renderCell(row, rowIdx)}
             </td>
           );
         })}
       </tr>
     );
   },
 });
