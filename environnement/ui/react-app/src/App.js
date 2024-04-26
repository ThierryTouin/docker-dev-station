import React, { Component } from 'react'
import Card from './components/Card'
import classes from './App.module.css';

// Use environment vars for DOMAIN and API_KEY 
const TITLE = process.env.REACT_APP_TITLE; 

// Récupération des liens à partir des variables d'environnement
const toolsLink = process.env.REACT_APP_TOOLS_LINK || '';
const ddsLink = process.env.REACT_APP_DDS_LINK || '';
const other1Link = process.env.REACT_APP_OTHER1_LINK || '';


// Fonction pour créer un objet lien
const createLink = (id, title, url) => ({ id, title, url });

// Fonction pour créer un groupe avec ses liens
const createGroup = (group, linksString) => {
  const links = linksString.split(';').map(link => {
    const [id, title, url] = link.split(',');
    return createLink(id, title, url);
  });
  return { group, links };
};

// Création des groupes
const toolsGroup = createGroup('Tools', toolsLink);
const ddsGroup = createGroup('DDS', ddsLink);
const other1Group = createGroup('Other1', other1Link);



class App extends Component {

    state={
      apps:[],
      up:1
    }


  render() {

    this.state.apps.push(toolsGroup);
    this.state.apps.push(ddsGroup);
    this.state.apps.push(other1Group);
    
    return (
      <div className={classes.App}>
        <h1>{TITLE}</h1>
        <div className={classes.gridContainer}>
          {this.state.apps.map((item,index)=>{
            console.log(item.group);
              return <div className={classes.gridItem}><Card key={index} group={item.group} links={item.links} /></div>
          })}
        </div>
      </div>
    )
  }
}

export default App


