const enableInput = () => {
  document.querySelectorAll('.details-form-item').forEach((item) => {
    item.classList.remove('inactive-input');
  });
}


const displayUpdateDetailsBtn = () => {

  const updateBtn = document.getElementById('update-details-btn');
  const editBtn = document.getElementById('edit-details-btn');
  editBtn.addEventListener('click', (event) => {
    event.preventDefault();
    enableInput();
    editBtn.classList.add('hidden');
    updateBtn.classList.remove('hidden');
  });
}


displayUpdateDetailsBtn()
