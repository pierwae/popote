const displayNavbarMenu = () => {
  document.getElementById('open-navbar-menu').addEventListener('click', (event) => {
    document.getElementById('navbar-menu').classList.remove('hidden');
  });
}

const hideNavbarMenu = () => {
  document.getElementById('close-navbar-menu').addEventListener('click', (event) => {
    document.getElementById('navbar-menu').classList.add('hidden');
  });
}

displayNavbarMenu()
hideNavbarMenu()
