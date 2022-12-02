import React, { Component } from "react";
import classes from './Url.module.css';

class url extends Component {



    render() {
        return(
            <a 
                className={classes.Url} 
                key={this.props.id} 
                href={this.props.url} 
                target="_blank" 
                rel="noreferrer"
            >
                    {this.props.url}
            </a>
        );
    }
}

export default url;