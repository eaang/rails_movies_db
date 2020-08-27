import $ from 'jquery';

const dropdowns = () => {
  $('.dropdown.keep-open').on({
    "shown.bs.dropdown": function() { this.closable = false; },
    "click":             function() { this.closable = true; },
    "hide.bs.dropdown":  function() { return this.closable; }
  });
}

export { dropdowns };
