

const showAnswer = () => {
  let i = 0;
  let card = document.getElementById(i);
  card.classList.toggle("d-none")

  const button = document.querySelector('#btn-show')
  button.addEventListener('click', (event) => {
    card.classList.toggle("d-none")
    i = i + 1
    card = document.getElementById(i)
    card.classList.toggle("d-none")
    i = 0

  });


};



export { showAnswer };
