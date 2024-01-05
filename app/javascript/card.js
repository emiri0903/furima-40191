const pay = () => {
  const payjp = Payjp('pk_test_56a99491a6ee536096bbe004')
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);