import React, { Component } from 'react'
import Url from './components/Url'

class App extends Component {
    state={
      apps:[
        {id:100,title:' Admin db',url:'http://localhost:8000'},
        {id:101,title:' Admin container',url:'http://localhost:9999'},
        {id:102,title:' Admin logs',url:'http://localhost:9998'},
        {id:200,title:' Liferay',url:'http://localhost:18080'},
        {id:700,title:' Liferay',url:'https://dev.o2.local'},
        
      ],
      up:1
    }
  render() {
    return (
      <div>
        <h1>Ecmd UI</h1>
        {this.state.apps.map(item=>{
          return <Url id={item.id} url={item.url} title={item.title} />
        })}
      </div>
    )
  }
}

export default App


