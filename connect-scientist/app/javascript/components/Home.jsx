import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center bg-expert">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Find Your Experts</h1>
        <p className="lead">
          It is hard to meet people with expertise during COVID! <br/>
          Let's meet a new expert.
        </p>
        <hr className="my-4" />
        <Link
          to="/friends"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Experts
        </Link>
      </div>
    </div>
  </div>
);
