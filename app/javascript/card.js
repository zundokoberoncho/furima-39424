document.addEventListener("turbo:load", function() {
  const pay = (form) => {
    const publicKey = gon.public_key;
    const payjp = Payjp(publicKey);
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    form.addEventListener("submit", (e) => {
      e.preventDefault();
      let renderDom;

      payjp.createToken(numberElement).then(function(response) {
        if (response.error) {
          form.classList.remove('form-submitted');
          return;
        } else {
          const token = response.id;
          renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='order_form[token]' type='hidden'>`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }

        if (renderDom && !renderDom.classList.contains('form-submitted')) {
          renderDom.classList.add('form-submitted');
          form.submit();
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();
        }
      });
    });
  };

  function init() {
    const form = document.getElementById('charge-form');
    if (form) {
      pay(form);
    }
  }

  init();
});

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);