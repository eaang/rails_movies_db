import $ from 'jquery';

const tableCode = () => {
  const dataTable = $('#datatable').DataTable({
    responsive: true,
    stateSave: true
  })
  .columns.adjust()
  .responsive.recalc();
  document.addEventListener("turbolinks:before-cache", function() {
    dataTable.destroy();
  });
}

export { tableCode };
