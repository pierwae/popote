import { formatPrice } from './mealPopUp';
import { updateSuborder } from './suborder';
import { deleteSuborder } from './suborder';
import { deleteSuborderHtml } from './suborder';

// Modification des quantités avec les boutons + et - de la page

const increaseQuantityNumber = (element) => {
  const quantity = parseInt(element.previousElementSibling.innerText, 10);
  const newQuantity = quantity + 1;
  element.previousElementSibling.innerText = newQuantity;
  return newQuantity;
}

const decreaseQuantityNumber = (element, deleteOption) => {
  const quantity = parseInt(element.nextElementSibling.innerText, 10);
  if (quantity > 1) {
    const newQuantity = quantity - 1;
    element.nextElementSibling.innerText = newQuantity;
    return newQuantity;
  } else if (quantity == 1 && deleteOption == true) {
    return 0
  } else {
    return quantity;
  }
}

//// PART 1 : MODIFICATIONS DES QUANTITÉS ET DU TOTAL DANS LE POP-UP ////////////////////////////////////////////////////////////////////////////////////////////////////////////

const updatePopUpTotal = (quantity) => {
  const price = document.getElementById('meal-pop-up').dataset.price;
  const total = formatPrice(parseFloat(quantity) * parseFloat(price));
  document.getElementById('meal-pop-up-total-btn').innerText = `Total ${total} €`;
}

const increaseQuantityMealPopUp = () => {
  const element = document.getElementById('meal-pop-up-plus-btn');
  element.addEventListener('click', (event) => {
    const quantity = increaseQuantityNumber(element); // UTILISE UNE FONCTION GÉNÉRIQUE (INTRO)
    updatePopUpTotal(quantity);
  });
}

const decreaseQuantityMealPopUp = () => {
  const element = document.getElementById('meal-pop-up-minus-btn');
  element.addEventListener('click', (event) => {
    const quantity = decreaseQuantityNumber(element); // UTILISE UNE FONCTION GÉNÉRIQUE (INTRO)
    updatePopUpTotal(quantity);
  });
}

// increaseQuantityMealPopUp()
// decreaseQuantityMealPopUp()

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PART 1bis : GESTION DES QUANTITÉS SUR LE PANIER (BASKET) /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

const increaseQuantityExistingSuborder = (element) => {
  element.addEventListener('click', (event) => {
    const suborderId = element.parentElement.parentElement.dataset.id;
    increaseQuantityNumber(element); // UTILISE UNE FONCTION GÉNÉRIQUE (INTRO)
    updateSuborder(suborderId, 1);
  });
}

const decreaseQuantityExistingSuborder = (element) => {
  element.addEventListener('click', (event) => {
    const suborderId = element.parentElement.parentElement.dataset.id;
    const quantity = decreaseQuantityNumber(element, true); // UTILISE UNE FONCTION GÉNÉRIQUE (INTRO)
    if (quantity == 0) {
      deleteSuborder(suborderId);
      deleteSuborderHtml(suborderId);
    } else {
      updateSuborder(suborderId, -1);

    }
  });
}

const selectExistingSuborderQuantityButtons = () => {
  document.querySelectorAll('.plus-btn').forEach((plusBtn) => {
    increaseQuantityExistingSuborder(plusBtn);
  });
  document.querySelectorAll('.minus-btn').forEach((minusBtn) => {
    decreaseQuantityExistingSuborder(minusBtn);
  });
}

const selectNewSuborderQuantityButtons = (id) => {
  const newSuborder = document.getElementById(`suborder-${id}`);
  const plusBtn     = newSuborder.querySelector('.plus-btn');
  const minusBtn    = newSuborder.querySelector('.minus-btn');
  increaseQuantityExistingSuborder(plusBtn);
  decreaseQuantityExistingSuborder(minusBtn);
}


// selectExistingSuborderQuantityButtons()
export { increaseQuantityMealPopUp };
export { decreaseQuantityMealPopUp };
export { selectExistingSuborderQuantityButtons };
export { selectNewSuborderQuantityButtons };
