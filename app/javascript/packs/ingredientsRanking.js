const removeLastRankingItemToLists = (items) => {
  items.querySelectorAll('.ingredient-qtt').forEach((list) => {
    list.children[list.children.length - 1].remove();
  });
}

deleteIngredientItem = (cross) => {
  cross.addEventListener('click', (event) => {
    const deletedItem = event.srcElement.parentElement.parentElement.parentElement;
    const items = deletedItem.parentElement;
    deletedItem.remove();
    removeLastRankingItemToLists(items);
  })
}

const targetCrossInOrderToDeleteItem = () => {
  document.querySelectorAll('.meal-dashboard-card').forEach((mealCard) => {
    const items = mealCard.querySelectorAll('.wrapper-item-ingredient');
    items.forEach((item) => {
      const cross = item.querySelector('.delete-ingredient-item');
      deleteIngredientItem(cross);
    });
  });
}

const buildHtmlContent = (value, ingredientsCount) => {
  const htmlContentBegin = `<div class='wrapper-item-ingredient row'>
                              <div class='col-2 p-0 grey-16  flex-row-center-center'>
                                <div class='form-group select required meal_ingredients_rank'>
                                  <select class='form-control select required p-0 details-form-item ingredient-qtt grey-14 flex-row-end-center' value='${value + 1}' name='meal[ingredients][${value}][rank]' id='meal_ingredients_${value}_rank'>`;

  let htmlContentMiddle = '';
  for (let i = 1; i < ingredientsCount + 1; i++) {
    htmlContentMiddle += `<option value='${i}.'>${i}.</option>`
  }

  const htmlContentEnd =         `<option selected='selected' value='${ingredientsCount + 1}.'>${ingredientsCount + 1}.</option>
                                </select>
                              </div>
                            </div>
                            <div class='p-0 col-8'>
                              <div class='form-group string required meal_ingredients_name'>
                                <input class='form-control string required details-form-item static-form-item flex-row-start-center' value='' placeholder='ex : Piment' type='text' name='meal[ingredients][${value}][name]' id='meal_ingredients_${value}_name'>
                              </div>
                            </div>
                            <div class='pb-3 px-0 col-2 grey-16 pointer flex-row-center-center'>
                              <div class='delete-ingredient-item'>
                                <i class='fas fa-times' aria-hidden='true'></i>
                              </div>
                            </div>
                          </div>`;

  const htmlContent = htmlContentBegin + htmlContentMiddle + htmlContentEnd;
  return htmlContent;
}

const addNewRankingItemToLists = (items, ingredientsCount) => {
  items.querySelectorAll('.ingredient-qtt').forEach((list) => {
    const htmlContent = `<option value='${ingredientsCount + 1}.'>${ingredientsCount + 1}.</option>`;
    list.insertAdjacentHTML("beforeend", htmlContent);
  });
}


const addNewIngredientItem = (value, ingredientsCount, items) => {
  const htmlContent = buildHtmlContent(value, ingredientsCount);
  addNewRankingItemToLists(items, ingredientsCount);
  items.insertAdjacentHTML("beforeend", htmlContent);
  const item = items.children[items.children.length - 1];
  const cross = item.querySelector('.delete-ingredient-item');
  deleteIngredientItem(cross);
}

const initIngredientAdding = () => {
  document.querySelectorAll('.meal-dashboard-card').forEach((mealCard) => {
    mealCard.querySelector('.add-ingredient-item').addEventListener('click', (event) => {
      const items = mealCard.querySelector('.wrapper-ingredients');
      const ingredientsCount = items.children.length;
      if (ingredientsCount == 0) {
        const value = 1;
        addNewIngredientItem(value, ingredientsCount, items);
      } else {
        const lastItem = items.children[ingredientsCount - 1]
        const value = parseInt(lastItem.querySelector('.ingredient-qtt').value, 10);
        addNewIngredientItem(value, ingredientsCount, items);
      }
    })
  });
}

targetCrossInOrderToDeleteItem()
initIngredientAdding()
