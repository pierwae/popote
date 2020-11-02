const addOrderToBasket = (id) => {
  document.getElementById('meal-pop-up-total-btn').addEventListener('click', (event) => {
    fetch()
  });
}

const updatePopUpDetails = (data) => {
  document.getElementById('meal-pop-up-name').innerHTML = data.name;
  document.getElementById('meal-pop-up-total-btn').innerHTML = data.price;
}

const getMealDetails = (id) => {
  fetch(`/meal_details/${id}`)
    .then(response => response.json())
    .then((data) => {
      updatePopUpDetails(data);
    });
}

const displayOrHideMealPopUp = () => {
  document.querySelectorAll('.open-exit-meal-pop-up').forEach((element) => {
    element.addEventListener('click', (event) => {
      const id = event.currentTarget.dataset.id;
      if (id !== undefined) {
        getMealDetails(id);
        addOrderToBasket(id);
      }

      document.getElementById('meal-pop-up').classList.toggle("hidden");
    });
  });
}

displayOrHideMealPopUp()
addOrderToBasket()
