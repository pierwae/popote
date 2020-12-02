const displayMealCard = (chevronUp, chevronDown, mealCardBody) => {
  chevronDown.addEventListener('click', (event) => {
    chevronDown.classList.add('hidden');
    chevronUp.classList.remove('hidden');
    mealCardBody.classList.remove('hidden');
  })
}

const hideMealCard = (chevronUp, chevronDown, mealCardBody) => {
  chevronUp.addEventListener('click', (event) => {
    chevronUp.classList.add('hidden');
    chevronDown.classList.remove('hidden');
    mealCardBody.classList.add('hidden');
  })
}

const targetElementsOfEachMealCard = () => {
  document.querySelectorAll('.meal-dashboard-card').forEach((mealCard) => {
    const chevronUp = mealCard.querySelector('.hide-card-body');
    const chevronDown = mealCard.querySelector('.display-card-body');
    const mealCardBody = mealCard.querySelector('.dashboard-card-body');
    displayMealCard(chevronUp, chevronDown, mealCardBody);
    hideMealCard(chevronUp, chevronDown, mealCardBody);
  });
}

export { targetElementsOfEachMealCard };

