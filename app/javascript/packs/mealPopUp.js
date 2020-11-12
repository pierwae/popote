//// PART 1 /////////////////////////////////////////////////////////////
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
//// PART 2 /////////////////////////////////////////////////////////////


const updateBasketContent = (data) => {
  const list = document.getElementById('basket-suborder-list');
  // console.log(list);
  const price = formatPrice(parseFloat(data.price) * parseFloat(data.quantity))
  list.insertAdjacentHTML('beforeend',
    `<div class='basket-suborder-area flex-row-sb-center w-100'>
      <div class='flex-row-center-center'>
        <div class='minus-btn pointer very-light-grey-14'><i class="fas fa-minus-circle"></i></div>
        <p class='grey-16 basket-suborder-number flex-row-center-center'>${data.quantity}</p>
        <div class='plus-btn pointer very-light-grey-14'><i class="fas fa-plus-circle"></i></div>
        <div class='ml-3'>
          <p class='grey-medium-16'>${data.meal_name}</p>
        </div>
      </div>
      <p class='grey-medium-16'>${price}€</p>
    </div>`);
}

const createSuborder = (mealId, basketId, quantity) => {
  console.log(mealId, basketId, quantity);
  fetch('/suborders', {
    method: 'POST',
    body: JSON.stringify({ meal_id: mealId, basket_id: basketId, quantity: quantity })
  })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      updateBasketContent(data);
    });
}

const isTheMealInTheBasket = (mealId, basketId, quantity) => {
  fetch(`/meals/${mealId}/baskets/${basketId}`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      if (data == 0) {
        createSuborder(mealId, basketId, quantity);
      }
    });
}

const addSuborderToBasket = () => {
  document.getElementById('meal-pop-up-total-btn').addEventListener('click', (event) => {
    const mealId = document.getElementById('meal-pop-up').dataset.id;
    const basketId = document.querySelector('.basket-card').dataset.id;
    const quantity = document.getElementById('meal-pop-up-quantity').innerText;
    isTheMealInTheBasket(mealId, basketId, quantity);
  });
}

addSuborderToBasket()


//// PART 3 /////////////////////////////////////////////////////////////
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

