window.general = {
	resetData: function() {
		$('#container-notifications').html(`<div class='text-center mt-2' id='no-notif'>Não existem notificações</div>`);
		$('#badge').text('0').hide();
	},
	cleanNotifications: function(el = false) {
		if (el) { 
			$(el).remove()
			var value = Number($('#badge').text())
			value == 1 ? this.resetData() : $('#badge').text(value - 1);
		} else { 
			this.resetData(); 
		}
	},
	toggleSidebar: function() {
		$('#page').toggleClass('sidebar-toggled');
		$('#accordionSidebar').toggleClass('toggled');
		if ($('#accordionSidebar').hasClass('toggled')) { 
			$('#accordionSidebar .collapse').collapse('hide');
			document.cookie = 'sidebar=active; path=/';
		} else {
			document.cookie = 'sidebar=inactive; path=/';
		}
	}
}