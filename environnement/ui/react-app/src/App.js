import React, { Component } from 'react'
import Url from './components/Url'

class App extends Component {
    state={
      apps:[
        {id:1,url:'http://localhost:18080'},
        {id:1,url:'http://localhost:18080'},
        {id:1,url:'http://localhost:18080'},
      ],
      up:1
    }
  render() {
    return (
      <div>
        <h1>Ecmd UI</h1>
        {this.state.apps.map(item=>{
          return <Url id={item.id} url={item.url} />
        })}
      </div>
    )
  }
}

export default App