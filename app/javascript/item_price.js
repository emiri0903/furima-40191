const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
   const inputValue = parseFloat(priceInput.value);
   const addTaxDom = document.getElementById("add-tax-price");
   const taxValue = inputValue * 0.1;
   const roundedTaxValue = Math.floor(taxValue);
   addTaxDom.innerHTML = Math.floor(roundedTaxValue);
   
   const profitDom = document.getElementById("profit");
   const profitValue = inputValue - roundedTaxValue;
   profitDom.innerHTML = Math.floor(profitValue);
});
