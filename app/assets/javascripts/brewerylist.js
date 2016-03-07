var BREWERIES = {};

BREWERIES.show = function(){
  $("#brewerytable tr:gt(0)").remove();

  var table = $("#brewerytable");

  $.each(BREWERIES.list, function(index, brewery){
    table.append('<tr>'
        + '<td>' + brewery['name'] + '</td>'
        + '<td>' + brewery['year'] + '</td>'
        + '</tr>');
  });
};

BREWERIES.sort_by_name = function(){
  BREWERIES.list.sort( function(a,b){
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sort_by_year = function(){
  BREWERIES.list.sort( function(a,b){
    return a.year - b.year;
  });
};

$(document).ready(function() {
  if ($("#brewerytable").length>0){
    $("#name").click(function (e){
      BREWERIES.sort_by_name();
      BREWERIES.show();
      e.preventDefault();
    });

    $("#year").click(function (e){
      BREWERIES.sort_by_year();
      BREWERIES.show();
      e.preventDefault();
    });



    $.getJSON('breweries.json', function(breweries){
      BREWERIES.list = breweries;
      BREWERIES.sort_by_name();
      BREWERIES.show();
    });
  }
});