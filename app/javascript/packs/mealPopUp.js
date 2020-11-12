
const updatePopUpDetails = (data) => {
  document.getElementById('meal-pop-up-name').innerHTML = data.name;
  document.getElementById('meal-pop-up-total-btn').innerHTML = data.price;
  document.getElementById('meal-pop-up').dataset.id = data.id;
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

const addSuborderToBasket = () => {
  document.getElementById('meal-pop-up-total-btn').addEventListener('click', (event) => {
    const id = document.getElementById('meal-pop-up').dataset.id;
    console.log(id);
  });
}

displayMealPopUp()
hideMealPopUp()
addSuborderToBasket()
