import React, { Component } from 'react'
import Card from './components/Card'
import classes from './App.module.css';



class App extends Component {
    state={
      apps:[
        {group:'Ecmd Admin',
         links: [
          {id:100,title:'Portainer',url:'http://localhost:9999'},
          {id:101,title:'Logs',url:'http://localhost:9998'},
          {id:103,title:'Omnidb',url:'http://localhost:8000'},
          {id:104,title:'Share File',url:'http://localhost:9980'},
          ]
        },  
        {group:'DDS',
         links: [
            {id:200,title:' Liferay',url:'http://localhost:18080'},
            {id:210,title:'Apm',url:'http://localhost:4000'},
            {id:220,title:'Sonar',url:'http://localhost:19000'}
         ]
        },    
        {group:'Liferay-build-image',
         links: [
            {id:700,title:' Liferay',url:'https://apache-domain'}
         ]
        },    
        {group:'O2',
         links: [
            {id:700,title:' Liferay',url:'https://dev.o2.local'}
         ]
        }
        

      ],
      up:1
    }
  render() {
    return (
      <div className={classes.App}>
        <h1>Ecmd UI</h1>
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


