import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    if (data.action == 'add_notification') {
      $('#container-notifications').prepend($('<form>', { onsubmit: 'general.cleanNotifications(this);', action: `/${data.notification.id}/clean_notification`, 'data-remote': true, method: 'post' }).append($('<button>', { class: 'dropdown-item', type: 'submit' }).text(data.notification.body)))
      $('#badge').text(Number($('#badge').text()) + 1).show();
      $('#no-notif').remove();
    }
  }
});
