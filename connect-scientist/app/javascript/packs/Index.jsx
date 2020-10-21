// This component will be added to application using 
// <%= javascript_pack_tag 'Index' %>

import React from "react";
import { render } from "react-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import App from "../components/App";


document.addEventListener("DOMContentLoaded", () => {
  //rendering App component in a div element, which is appended to the body.
  render(
    <App />,
    document.body.appendChild(document.createElement("div"))
  );
});
