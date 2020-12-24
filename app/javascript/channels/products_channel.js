import consumer from "./consumer"

consumer.subscriptions.create("ProductsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    //console.log(data.html);
    const storeElement = document.querySelector("div.store-for-channel")
    if (storeElement) {
      //alert('find store')
    	storeElement.innerHTML = data.html
    }
  }
});
