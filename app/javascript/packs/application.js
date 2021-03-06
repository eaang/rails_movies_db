// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require( 'datatables.net-bs4' );
require( 'datatables.net-buttons-bs4' );
require( 'datatables.net-responsive-bs4' );
require("jquery");
require("chartkick");
require("chart.js");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// External imports
import "bootstrap";
import $ from 'jquery';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { apiCall } from '../components/api_call'
import { tableCode } from '../components/datatable'
import { toggler } from '../components/new_movie_toggle'
import { dropdowns } from '../components/dropdowns'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  $(function () {
    $('[data-toggle="popover"]').popover()
  })
  apiCall();
  tableCode();
  toggler();
  dropdowns();
});

import "controllers"
