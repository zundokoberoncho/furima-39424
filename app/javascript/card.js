const pay = (form) => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    let renderDom;  // ここで変数を宣言

    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        form.classList.remove('form-submitted');  // エラー時にform-submittedを削除
        return;
      } else {
        const token = response.id;
        renderDom = document.getElementById("charge-form");  // ここで変数に値を代入
        const tokenObj = `<input value=${token} name='order_form[token]' type='hidden'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      if (renderDom && !renderDom.classList.contains('form-submitted')) {  // renderDomが存在するかもチェック
        renderDom.classList.add('form-submitted');
        document.getElementById("charge-form").submit();
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
      } else {
      }
    });
  });
};

document.addEventListener("turbo:load", init);

function init() {

  const form = document.getElementById('charge-form');
  if (form) {
    pay(form);  // pay関数を呼び出す
  } else {
  }
}
