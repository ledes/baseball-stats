
var Blobs = Blobs || {};

Blobs.TableColumns = [
  {
    header: "Name",
    metric: "name",
    renderCell: function(statistic) {return statistic.name},
    sortable: true,
    nonNumeric: true
  },
  {
    header: "Surname",
    metric: "given_name",
    renderCell: function(statistic) {return statistic.given_name},
    sortable: true,
    nonNumeric: true
  },
  {
    header: "Position",
    metric: "position",
    renderCell: function(statistic) {return statistic.position},
    sortable: true,
    nonNumeric: true
  },
  {
    header: "AVG",
    metric: "avg",
    renderCell: function(statistic) {return statistic.avg},
    sortable: true,
  },
  {
    header: "Runs",
    metric: "runs",
    renderCell: function(statistic) {return statistic.runs},
    sortable: true,
  },
  {
    header: "Home runs",
    metric: "home_runs",
    renderCell: function(statistic) {return statistic.home_runs},
    sortable: true,
  },
  {
    header: "RBI",
    metric: "rbi",
    renderCell: function(statistic) {return statistic.rbi},
    sortable: true,
  },
  {
    header: "SB",
    metric: "sb",
    renderCell: function(statistic) {return statistic.sb},
    sortable: true,
  },
  {
    header: "OPS",
    metric: "ops",
    renderCell: function(statistic) {return statistic.ops},
    sortable: true,
  },
];
