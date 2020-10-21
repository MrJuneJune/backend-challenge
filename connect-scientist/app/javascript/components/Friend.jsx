import React from "react";
import { Link } from "react-router-dom";

class Friend extends React.Component {
  constructor(props) {
    super(props);
    this.state = { profile: { friends: [], payload: {} }, keywords: "",  recommended_friends: [] };
    this.grabData = this.grabData.bind(this);
    this.onChange = this.onChange.bind(this);
    this.findExpert = this.findExpert.bind(this);
  }

  componentDidMount() {
    const {
      match: {
        params: { id }
      }
    } = this.props;
    const url = `/api/v1/profiles/${id}`;
    this.grabData(url)
  }

  onChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }


  grabData(url) {
    this.setState({ profile: { friends: [], payload: {} }, keywords: "",  recommended_friends: [] });
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => this.setState({ profile: response }))
  }

  findExpert(event) {
    event.preventDefault();
    const {
      match: {
        params: { id }
      }
    } = this.props;
    const url = `/api/v1/profiles/${id}/find_expert`;

    if (this.state.keywords.length == 0)
      return;


    const body = {
      "keywords": this.state.keywords
    };

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body)
    })
    .then(response => {
      console.log(response)
      if (response.ok) {
        return response.json();
      }
      throw new Error("Network response was not ok.");
    })
    .then(response => this.setState({ recommended_friends: response }))
    .catch(error => console.log(error.message));
  }

  render() {
    const { profile, recommended_friends } = this.state;
    let friendsList = "No friends added";
    if (profile.friends.length > 0) {
      friendsList = (
        <>
          <h6 className="mr-2">
            Friends :
          </h6>
          <div className="d-flex ml-3">
            {
              profile.friends.map((friend, index) => {
                return (
                  <Link key={`friend-${profile.id}-${friend.id}`} 
                        to={`/friend/${friend.id}`} 
                        className="btn custom-button mr-2"
                        onClick={()=>this.grabData(friend.url)}>
                    {friend.name}
                  </Link>
                )
              })
            }
          </div>
        </>
      )
    }

    var headingData = []
    if (profile.payload && (Object.keys(profile.payload).length > 0)) {
      headingData = Object.keys(profile.payload).map((key, index) => (
        <>
          <h6 className="mr-2">
            {key}:
          </h6>
          <ul key={`headingDataParent-${profile.id}-${index}`}>
            {
              profile.payload[key].map((val, index2)=>{
                return (
                  <li key={`headingsData-${profile.id}-${key}-${index+index2}`}> 
                    {val}
                  </li>
                )
              })
            }
          </ul>
          <hr/>
        </>
      ));
    }

    const expertSearch = (
      <div className="d-flex justify-content-center form_container mt-2">
        <form onSubmit={this.findExpert}>
          <div className="d-flex justify-content-center mt-3">
            Find Expert Search 
          </div>
          <div className="input-group mb-3">
            <div className="input-group-append">
              <input type="keywords" 
                   className="form-control" 
                   id="keywords" 
                   name="keywords"
                   required
                   onChange={this.onChange}
              />
            </div>
          </div>
          <div className="d-flex justify-content-center mt-3">
            <button type="button" type="submit" name="button" className="btn btn-primary">Search</button>
          </div>
        </form>
      </div>
    )

    const profileProfile = (
      <div className="col-md-4 mb-3">
        <div className="card">
          <div className="card-body">
            <div className="d-flex flex-column align-items-center text-center">
              <img src="data:image/png;base64,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" alt="Admin" className="rounded-circle" width={150} />
              <div className="mt-3">
                <h4>{profile.name}</h4>
                <button className="btn btn-primary">Add as a friend</button>
                <Link to="/friends" className="btn btn-link">
                  Back to Friends
                </Link>
              </div>
            </div>
          </div>
        </div>
        {expertSearch}
      </div>
    )

    var profileAttributes = []
    Object.keys(profile).forEach((k, index) => {
      if (k != "friends" && k != "payload") {
        profileAttributes.push(
        <div key={`friend-${profile.id}-${k}`}>
          <div className="row">
            <div className="col-sm-3">
              <h6 className="mb-0">{k}</h6>
            </div>
            <div className="col-sm-9 text-secondary">
              {profile[k]}
            </div>
          </div>
          <hr/>
        </div>)
      }
    });

    let recommendedFriends = (
      <>
      </>
    );
    if (recommended_friends.length > 0) {
      recommendedFriends = (
        <>
          <h6 className="mr-2">
            Recommended Friends :
          </h6>
          <div className="d-flex ml-3">
            {
              recommended_friends.map((recommended_friend, index) => {
                return (
                  <Link key={`recommended-friend-${recommended_friend.id}`} 
                        to={`/friend/${recommended_friend.id}`} 
                        className="btn custom-button mr-2"
                        onClick={()=>this.grabData(recommended_friend.url)}>
                    {recommended_friend.name} || {recommended_friend.path}
                  </Link>
                )
              })
            }
          </div>
        </>
      )
    }

    const profileInfo = (
      <div className="col-md-8">
        <div className="card mb-3">
          <div className="card-body">
            {profileAttributes}
            {friendsList}
            <hr/>
            {headingData}
            {recommendedFriends}
          </div>
        </div>
      </div>
    )
 

    return (
      <div className="container py-5">
        <div className="main-body">
          <div className="row gutters-sm">
            {profileProfile}
            {profileInfo}
          </div>
        </div>
      </div>
    );
  }
}
export default Friend;
