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

      // 既存のtoken情報を削除
      const existingToken = document.querySelector("input[name='order_form[token]']");
      if (existingToken) {
        existingToken.remove();
      }

      payjp.createToken(numberElement).then(function(response) {
        if (response.error) {
          form.classList.remove('form-submitted');  // エラー時に 'form-submitted' クラスを削除
          alert('カード情報が正しくありません。'); // ユーザーにエラーを通知
          return;
        } else {
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='order_form[token]' type='hidden'>`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }

        if (!form.classList.contains('form-submitted')) {
          form.classList.add('form-submitted');
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