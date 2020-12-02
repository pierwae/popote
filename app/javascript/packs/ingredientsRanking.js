const removeLastRankingItemToLists = (items) => {
  items.querySelectorAll('.ingredient-qtt').forEach((rankList) => {
    rankList.children[rankList.children.length - 1].remove();
  });
}

deleteIngredientItem = (item) => {
  const crossBtn = item.querySelector('.delete-ingredient-item');
  crossBtn.addEventListener('click', (event) => {
    const items = item.parentElement;
    item.remove();
    removeLastRankingItemToLists(items);
  })
}

// FONCTION DE DÉPART : SUPPRESSION D'UN ITEM APRÈS CLICK SUR LA CROIX ASSOCIÉE
const targetEachItem = () => {
  document.querySelectorAll('.meal-dashboard-card').forEach((mealCard) => {
    const items = mealCard.querySelectorAll('.wrapper-item-ingredient');
    items.forEach((item) => {
      deleteIngredientItem(item);
    });
  });
}

const buildHtmlContent = (ingredientsCount, indexNewItem) => {
  const htmlContentBegin = `<div class='wrapper-item-ingredient row'>
                              <div class='col-2 p-0 grey-16  flex-row-center-center'>
                                <div class='form-group select required meal_ingredients_rank'>
                                  <select class='form-control select required p-0 details-form-item ingredient-qtt grey-14 flex-row-end-center' value='' name='meal[ingredients][${indexNewItem}][rank]' id='meal_ingredients_${indexNewItem}_rank'>`;

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
                                <input class='form-control string required details-form-item static-form-item flex-row-start-center' value='' placeholder='ex : Piment' type='text' name='meal[ingredients][${indexNewItem}][name]' id='meal_ingredients_${indexNewItem}_name'>
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


const addNewIngredientItem = (ingredientsCount, items, indexNewItem) => {
  const htmlContent = buildHtmlContent(ingredientsCount, indexNewItem);
  addNewRankingItemToLists(items, ingredientsCount);
  items.insertAdjacentHTML("beforeend", htmlContent);
  const lastItem = items.children[items.children.length - 1];
  deleteIngredientItem(lastItem);
}

// FONCTION DE DÉPART : CRÉATION D'UN NOUVEL ITEM APRÈS CLICK SUR 'Ajouter un ingrédient'
const initIngredientAdding = () => {
  document.querySelectorAll('.ingredients-area').forEach((mealCard) => {
    let indexNewItem = mealCard.querySelector('.wrapper-ingredients').children.length;
    mealCard.querySelector('.add-ingredient-item').addEventListener('click', (event) => {
      indexNewItem += 1;
      const items = mealCard.querySelector('.wrapper-ingredients');
      const ingredientsCount = items.children.length;
      addNewIngredientItem(ingredientsCount, items, indexNewItem);
    })
  });
}

targetEachItem()
initIngredientAdding()
// export { targetEachItem };
// export { initIngredientAdding };
