import React, { Component } from 'react';
import Card from './components/Card';
import classes from './App.module.css';

// Use environment vars for TITLE
const TITLE = process.env.REACT_APP_TITLE; 

// Fonction pour charger les liens depuis un fichier JSON
const fetchLinksData = async () => {
  const response = await fetch('./links.json');
  return response.json();
};

class App extends Component {
  state = {
    apps: [],
  };

  componentDidMount() {
    fetchLinksData().then((data) => {
      console.log(JSON.stringify(data));
      this.setState({ apps: data });
    });
  }

  render() {
    const sortedApps = [...this.state.apps].sort((a, b) => {
      if (a.group == "undefined") return 1;
      if (b.group == "undefined") return -1;
      return 0;
    });

    return (
      <div className={classes.App}>
      <h1>{TITLE}</h1>
      <div className={classes.gridContainer}>
        {sortedApps.map((item, index) => (
        <div key={index} className={classes.gridItem}>
          <Card group={item.group} links={item.links} />
        </div>
        ))}
      </div>
      </div>
    );
  }
}

export default App;
