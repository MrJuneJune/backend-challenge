// Routing components in this file.
import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "./Home";
import Friend from "./Friend";
import Friends from "./Friends";

export default prop =>
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/friends" exact component={Friends} />
      <Route path="/friend/:id" exact component={Friend} />
    </Switch>
  </Router>;
