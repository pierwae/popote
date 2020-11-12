// Fonction pour mettre en forme le prix

const formatPrice = (price) => {
  return price.toFixed(2).replace('.',',');
}

// Fonctions de modification des nombres sur tous les boutons + et - de la page
// argument : element !!!

const increaseQuantityNumber = (element) => {
  const quantity = parseInt(element.previousElementSibling.innerText, 10);
  const newQuantity = quantity + 1;
  element.previousElementSibling.innerText = newQuantity;
  return newQuantity;
}

const decreaseQuantityNumber = (element) => {
  const quantity = parseInt(element.nextElementSibling.innerText, 10);
  if (quantity > 1) {
    const newQuantity = quantity - 1;
    element.nextElementSibling.innerText = newQuantity;
    return newQuantity;
  } else {
    return quantity;
  }
}

// Fin

const updatePopUpTotal = (quantity) => {
  const price = document.getElementById('meal-pop-up').dataset.price;
  const total = formatPrice(parseFloat(quantity) * parseFloat(price));
  document.getElementById('meal-pop-up-total-btn').innerText = `Total ${total}€`;
}

const increaseQuantityMealPopUp = () => {
  const element = document.getElementById('meal-pop-up-plus-btn');
  element.addEventListener('click', (event) => {
    const quantity = increaseQuantityNumber(element);
    updatePopUpTotal(quantity);
  });
}

const decreaseQuantityMealPopUp = () => {
  const element = document.getElementById('meal-pop-up-minus-btn');
  element.addEventListener('click', (event) => {
    const quantity = decreaseQuantityNumber(element);
    updatePopUpTotal(quantity);
  });
}

increaseQuantityMealPopUp()
decreaseQuantityMealPopUp()

// FIN

const isTheMealInTheBasket = (mealId, basketId) => {
  fetch(`/meals/${mealId}/baskets/${basketId}`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
    });
}

const addSuborderToBasket = () => {
  document.getElementById('meal-pop-up-total-btn').addEventListener('click', (event) => {
    const mealId = document.getElementById('meal-pop-up').dataset.id;
    const basketId = document.querySelector('.basket-card').dataset.id;
    isTheMealInTheBasket(mealId, basketId);
  });
}

addSuborderToBasket()
// Apparation du pop up

const updatePopUpDetails = (data) => {
  document.getElementById('meal-pop-up-name').innerHTML = data.name;
  document.getElementById('meal-pop-up-total-btn').innerHTML = `Total ${formatPrice(data.price)}€`;
  document.getElementById('meal-pop-up').dataset.id = data.id;
  document.getElementById('meal-pop-up').dataset.price = data.price;
}

const getMealDetails = (id) => {
  fetch(`/meal_details/${id}`)
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

displayMealPopUp()
hideMealPopUp()

