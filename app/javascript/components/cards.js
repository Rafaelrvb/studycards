

const showAnswer = () => {
  const button = document.querySelector('#btn-show');
  const question = document.getElementById('0');
  const answer = document.getElementById('1');
  const btns = document.getElementById('2')
  if (button) {
    button.addEventListener('click', (event) => {
      question.classList.toggle("d-none")

      answer.classList.toggle("d-none")
      btns.classList.toggle("d-none")

    });
  }
};



export { showAnswer };
