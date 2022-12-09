import React, { Component } from "react";
import classes from './Url.module.css';

class url extends Component {



    render() {
        return(
            <div className={classes.Url}>
                <div>    
                    {this.props.id} - <span> {this.props.title} : </span>
                    <a 
                        href={this.props.url} 
                        target="_blank" 
                        rel="noreferrer"
                    >
                            {this.props.url}
                    </a>
                </div>    
            </div>
        );
    }
}

export default url;