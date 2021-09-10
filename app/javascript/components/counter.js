function animate(obj, initVal, lastVal, duration) {

  let startTime = null;

  //get the current timestamp and assign it to the currentTime variable
  let currentTime = Date.now();

  //pass the current timestamp to the step function
  const step = (currentTime) => {

    //if the start time is null, assign the current time to startTime
    if (!startTime) {
      startTime = currentTime;
    }

    //calculate the value to be used in calculating the number to be displayed
    const progress = Math.min((currentTime - startTime) / duration, 1);

    //calculate what to be displayed using the value gotten above
    obj.innerHTML = Math.floor(progress * (lastVal - initVal) + initVal);

    //checking to make sure the counter does not exceed the last value (lastVal)
    if (progress < 1) {
      window.requestAnimationFrame(step);
    }
    else {
      window.cancelAnimationFrame(window.requestAnimationFrame(step));
    }
  };

  //start animating
  window.requestAnimationFrame(step);
}

let text1 = document.getElementById('0101');
let text2 = document.getElementById('0102');
let text3 = document.getElementById('0103');
let text4 = document.getElementById('0104');
let text5 = document.getElementById('0105');
let text6 = document.getElementById('0106');
let text7 = document.getElementById('0107');

const load = () => {
  animate(text1, 0, text1.innerHTML, 2500);
  animate(text2, 0, text2.innerHTML, 2500);
  animate(text3, 0, text3.innerHTML, 2500);
  animate(text4, 0, text4.innerHTML, 2500);
  animate(text5, 0, text5.innerHTML, 2500);
  animate(text6, 0, text6.innerHTML, 2500);
  animate(text7, 0, text7.innerHTML, 2500);
}

export { load };
