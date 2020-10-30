const displaySearchbar = () => {
  document.getElementById('searchbar-access').addEventListener('click', (event) => {
    document.getElementById('searchbar').style.display = 'flex';
    event.srcElement.style.display = 'none';
    console.log(event);
  });
}

displaySearchbar()
