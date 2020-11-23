import { formatPrice } from './mealPopUp';
import { calculBasketTotalPrice } from './mealPopUp';
import { selectNewSuborderQuantityButtons } from './quantityButtons';



const updateBasketContent = (data) => {
  const list = document.getElementById('basket-suborder-list');
  const price = formatPrice(parseFloat(data.price) * parseFloat(data.quantity)) // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
  const htmlContent = `<div data-id='${data.suborder_id}' id='suborder-${data.suborder_id}' class='basket-suborder-area flex-row-sb-center w-100'>
                        <div class='flex-row-center-center'>
                          <div class='minus-btn pointer very-light-grey-14'><i class="fas fa-minus-circle"></i></div>
                          <p class='grey-16 basket-suborder-number flex-row-center-center'>${data.quantity}</p>
                          <div class='plus-btn pointer very-light-grey-14'><i class="fas fa-plus-circle"></i></div>
                          <div class='ml-3'>
                            <p class='grey-medium-16'>${data.meal_name}</p>
                          </div>
                        </div>
                        <p class='basket-suborder-price grey-medium-16'>${price} €</p>
                      </div>`
  list.insertAdjacentHTML('beforeend', htmlContent);
  selectNewSuborderQuantityButtons(data.suborder_id); // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
  calculBasketTotalPrice(); // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
}

const createSuborder = (mealId, basketId, quantity) => {
  fetch('/basket_suborders', {
    method: 'POST',
    body: JSON.stringify({ meal_id: mealId, basket_id: basketId, quantity: quantity })
  })
    .then(response => response.json())
    .then((data) => {
      updateBasketContent(data);
    });
}

const updateSuborderContentInBasket = (data) => {
  const suborder = document.getElementById(`suborder-${data.suborder_id}`);
  const price = formatPrice(parseFloat(data.price) * parseFloat(data.quantity)) // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
  suborder.querySelector('.basket-suborder-number').innerText = data.quantity;
  suborder.querySelector('.basket-suborder-price').innerText = `${price} €`;
  calculBasketTotalPrice(); // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
}

const deleteSuborderHtml = (suborderId) => {
  document.getElementById(`suborder-${suborderId}`).remove();
}

const deleteSuborder = (suborderId) => {
  fetch(`/basket_suborders/${suborderId}`, {
    method: 'DELETE'
  })
    .then(response => response.json())
    .then((data) => {
      calculBasketTotalPrice(); // RÉFÉRENCE À UNE MÉTHODE IMPORTÉE
    });
}

const updateSuborder = (suborderId, quantity) => {
  fetch(`/basket_suborders/${suborderId}`, {
    method: 'PATCH',
    body: JSON.stringify({ quantity: quantity })
  })
    .then(response => response.json())
    .then((data) => {
      updateSuborderContentInBasket(data);
    });
}

const isTheMealInTheBasket = (mealId, basketId, quantity) => {
  fetch(`/meals/${mealId}/baskets/${basketId}`)
    .then(response => response.json())
    .then((data) => {
      if (data == 0) {
        createSuborder(mealId, basketId, quantity);
      } else {
        const suborderId = data;
        updateSuborder(suborderId, quantity);
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


// addSuborderToBasket()
export { addSuborderToBasket };
export { updateSuborder };
export { deleteSuborder };
export { deleteSuborderHtml };
