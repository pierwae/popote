const openCookShow = () => {
  document.querySelectorAll('.cook-card').forEach((card) => {
    card.addEventListener('click', (event) => {
      event.preventDefault();
      console.log(event);
    });
  });
}

openCookShow()
