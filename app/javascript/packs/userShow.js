const displayUpdateAddressBtn = () => {
  document.querySelectorAll('.address-form-item').forEach((item) => {
    item.addEventListener('keydown', (event) => {
      document.getElementById('update-details-btn').classList.remove('inactive-btn');
    });
  });
}


displayUpdateAddressBtn()
