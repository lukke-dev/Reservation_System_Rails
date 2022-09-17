import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import '../stylesheets/application'
import "@fortawesome/fontawesome-free/css/all"
import ApexCharts from "apexcharts";
window.ApexCharts = ApexCharts;
var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(window).resize(function() {
	if ($(window).width() < 768) { $('.sidebar .collapse').collapse('hide'); };
	if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
		$("body").addClass("sidebar-toggled");
		$(".sidebar").addClass("toggled");
		$('.sidebar .collapse').collapse('hide');
	};
});

$(document).on('scroll', function() {
	var scrollDistance = $(this).scrollTop();
	if (scrollDistance > 100) {
		$('.scroll-to-top').fadeIn();
	} else {
		$('.scroll-to-top').fadeOut();
	}
});