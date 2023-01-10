// importing the Cansiter in my JS file
import { dbank_backend } from "../../declarations/dbank_backend";

async function check() {
  // we wait for the result to comeback
  const checkAmount = await dbank_backend.checkBalance();
  console.log(checkAmount);
  await update(checkAmount);
}

/**/

/**/

window.addEventListener("load", async () => {
  // async - to match the "query" speed and
  // not wait for other parts of the programs to load up first.
  // dbank_backend.reset();
  check();
});

/**/

/**/

async function update(checkAmount) {
  // asynchronously update the #value once we get the checkAmount
  // and display it using DOM
  // console.log(document.querySelector(`#value`).innerHTML);
  document.querySelector(`#value`).innerText =
    Math.round(checkAmount * 100) / 100;
}

/**/

/**/

document.querySelector(`form`).addEventListener("submit", async (event) => {
  // for preventing the default html-form behaviour
  event.preventDefault();

  console.log("entered form");

  // storing the entered input in const variables
  const inputAmount = parseFloat(document.getElementById(`input-amount`).value);
  console.log(inputAmount);
  const outputAmount = parseFloat(
    document.getElementById(`withdrawal-amount`).value
  );
  console.log(outputAmount);

  // css
  // console.log(event.target[2]);
  // event.target.getElementById(`submit-btn`).setAttribute("disabled", true);
  event.target[2].setAttribute("disabled", true);

  // checks if the input box is empty or not
  // then only it calls the Canister functions
  if (document.getElementById(`input-amount`).value.length != 0) {
    await dbank_backend.TopUp(inputAmount);
  }
  if (document.getElementById(`withdrawal-amount`).value.length != 0) {
    await dbank_backend.TopDown(outputAmount);
  }

  dbank_backend.compound();

  // it will remove the css styles
  // event.target.getElementById(`submit-btn`).removeAttribute("disabled");
  event.target[2].removeAttribute("disabled");

  // clear the input box
  document.getElementById(`input-amount`).value = "";
  document.getElementById(`withdrawal-amount`).value = "";

  // update(checkAmount);
  check();

  return false;
});
