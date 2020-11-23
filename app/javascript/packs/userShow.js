const displayUpdateDetailsBtn = () => {
  document.querySelectorAll('.details-form-item').forEach((item) => {
    item.addEventListener('keydown', (event) => {
      document.getElementById('update-details-btn').classList.remove('inactive-btn');
    });
  });
}

const displayUpdateAddressBtn = () => {
  document.querySelectorAll('.address-form-item').forEach((item) => {
    item.addEventListener('keydown', (event) => {
      document.getElementById('update-address-btn').classList.remove('inactive-btn');
    });
  });
}

displayUpdateDetailsBtn()
displayUpdateAddressBtn()
