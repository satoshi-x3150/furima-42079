function price() {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    // 販売手数料 (10%)
    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;

    // 販売利益 (入力金額 - 販売手数料)
    const profit = inputValue - tax;
    profitDom.innerHTML = profit;
  });
}

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
