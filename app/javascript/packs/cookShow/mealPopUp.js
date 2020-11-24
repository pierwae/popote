////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// INTRO : MÉTHODES GÉNÉRALES ////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Formattage des pric en js
const formatPrice = (price) => {
  return price.toFixed(2).replace('.',',');
}

const calculBasketTotalPrice = () => {
  const basketId = document.querySelector('.basket-card').dataset.id;
  fetch(`/baskets/${basketId}/total_price`)
    .then(response => response.json())
    .then((data) => {
      document.getElementById('basket-price').innerText = `${data} €`
    });
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PART 3 : APPARITION/DISPARITION DU POP-UP /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

const updatePopUpDetails = (data) => {
  document.getElementById('meal-pop-up-name').innerHTML = data.name;
  document.getElementById('meal-pop-up-total-btn').innerHTML = `Total ${formatPrice(data.price)} €`;
  document.getElementById('meal-pop-up').dataset.id = data.id;
  document.getElementById('meal-pop-up').dataset.price = data.price;
  document.getElementById('meal-pop-up-quantity').innerHTML = 1;
}

const getMealDetails = (id) => {
  fetch(`/meals/${id}/details`)
    .then(response => response.json())
    .then((data) => {
      updatePopUpDetails(data);
    });
}

const displayMealPopUp = () => {
  document.querySelectorAll('.meal-card').forEach((element) => {
    element.addEventListener('click', (event) => {
      const id = event.currentTarget.dataset.id;
      getMealDetails(id);
      document.getElementById('meal-pop-up').classList.remove("hidden");
    });
  });
}

const hideMealPopUp = () => {
  document.querySelectorAll('.quit-meal-pop-up').forEach((element) => {
    element.addEventListener('click', (event) => {
      document.getElementById('meal-pop-up').classList.add("hidden");
    });
  });
}

// displayMealPopUp()
// hideMealPopUp()
export { displayMealPopUp };
export { hideMealPopUp };
export { formatPrice };
export { calculBasketTotalPrice };
