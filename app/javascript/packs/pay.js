// 全てのturbo:loadイベントに対する処理を一箇所で管理
document.addEventListener("turbo:load", function() {
  console.log("DOM fully loaded and parsed");

  // pay.jsの処理
  const form = document.getElementById('charge-form');
  if (form) {
    // pay関数の内容をここに書く
  } else {
    console.error("Form element with ID 'charge-form' not found!");
  }

  // item_price.jsの処理
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput && addTaxDom && profitDom) {
    // 価格計算の処理をここに書く
  }
});