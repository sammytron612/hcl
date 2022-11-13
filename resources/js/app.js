
import axios from 'axios';

require('./bootstrap');



import moment from 'moment';



/*
Vue.filter('timeago', function(value) {
    return moment.utc(value).local().fromNow();
});

Vue.filter('formatDate', function(date){
    return moment(date).format("dddd, MMMM Do YYYY");
});

window.axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

import Swal from 'sweetalert2'
window.Swal = Swal
const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  onOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})
window.Toast = Toast

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}


Vue.filter('highlight', function (words, query) {
    var title = (words.toLowerCase().replace(query.toLowerCase(), '<u>' + query + '</u>')).capitalize();

    return title
});

*/

(function($) {

	"use strict";

	var fullHeight = function() {

		$('.js-fullheight').css('height', $(window).height());
		$(window).resize(function(){
			$('.js-fullheight').css('height', $(window).height());
		});

	};
	fullHeight();

	$('#sidebarCollapse').on('click', function () {
      $('#sidebar').toggleClass('active');
  });

})(jQuery);
