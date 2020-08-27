import $ from 'jquery';

const tableCode = () => {
  const dataTable = $('#datatable').DataTable({
    responsive: true,
    stateSave: true
  })
  .columns.adjust()
  .responsive.recalc();
  const genreTable = $('#genretable').DataTable({
    responsive: true,
    stateSave: true,
    "columns": [
      { "width": "50px" },
      { "width": "50px" },
      { "width": "200px" },
      null
    ]
  })
  .columns.adjust()
  .responsive.recalc();
  document.addEventListener("turbolinks:before-cache", function() {
    dataTable.destroy();
    genreTable.destroy();
  });
}

export { tableCode };
