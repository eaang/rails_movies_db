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
      null,
      null,
      null,
      { "width": "55%" }
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
