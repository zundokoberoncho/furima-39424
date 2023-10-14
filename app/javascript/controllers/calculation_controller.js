import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.priceInput = document.getElementById("item-price");
    this.feeOutput = document.getElementById("add-tax-price");
    this.profitOutput = document.getElementById("profit");

    this.priceInput.addEventListener("input", this.calculate.bind(this));
  }

  calculate() {
    const inputValue = this.priceInput.value;
    const fee = Math.floor(inputValue * 0.1);
    const profit = inputValue - fee;

    this.feeOutput.textContent = fee;
    this.profitOutput.textContent = profit;
  }
}

