import React, { Component } from 'react'
import Card from './components/Card'

class App extends Component {
    state={
      apps:[
        {group:'admin',
         links: [
            {id:100,title:' Admin db',url:'http://localhost:8000'},
            {id:101,title:' Admin container',url:'http://localhost:9999'},
          {id:102,title:' Admin logs',url:'http://localhost:9998'}
          ]
        },  
        {group:'ecmd',
         links: [
            {id:200,title:' Liferay',url:'http://localhost:18080'}
         ]
        },    
        {group:'o2',
         links: [
            {id:700,title:' Liferay',url:'https://dev.o2.local'}
         ]
        }
      ],
      up:1
    }
  render() {
    return (
      <div>
        <h1>Ecmd UI</h1>
        {this.state.apps.map((item,index)=>{
          console.log(item.group);
          return <Card key={index} group={item.group} links={item.links} />
        })}
      </div>
    )
  }
}

export default App


