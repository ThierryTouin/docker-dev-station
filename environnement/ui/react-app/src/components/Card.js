import React, { Component } from "react";
import classes from './Card.module.css';
import Url from './Url'

class card extends Component {



    render() {
        return(
            <div className={classes.Card}>
                <div class="container">
                    <h4><b>{this.props.group}</b></h4> 
                    {this.props.links.map(item=>{
                       return <p><Url id={item.id} url={item.url} name={item.name} /></p> 
                    })}
                </div>
            </div>
        );
    }
}

export default card;