// Routing components in this file.
import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "./Home";

export default prop =>
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
    </Switch>
  </Router>;
