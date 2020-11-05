const redirectToCookShow = (cookId, basketId) => {
  document.location.href=`/baskets/${basketId}/cooks/${cookId}`;
}

const createNewBasket = (cookId) => {
  fetch('/new_basket')
    .then(response => response.json())
    .then((data) => {
      const basketId = data.id;
      redirectToCookShow(cookId, basketId);
    }
  );
}

const openCookShow = () => {
  document.querySelectorAll('.cook-card').forEach((card) => {
    card.addEventListener('click', (event) => {
      const cookId = card.dataset.cook_id;
      createNewBasket(cookId);
    });
  });
}

openCookShow()
