import React, { Component } from "react";
import classes from "./Url.module.css";

class Url extends Component {
  constructor(props) {
    super(props);
    this.state = {
      status: "checking", // Initialisation à "checking"
    };
    this.interval = null;
  }

  // Fonction pour vérifier l'état de l'URL
  checkUrl = async () => {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000); // Timeout de 5s

      await fetch(this.props.url, {
        method: "GET",
        mode: "no-cors", // Bypass CORS
        signal: controller.signal,
      });

      clearTimeout(timeoutId);
      this.setState({ status: "online" });
    } catch (error) {
      this.setState({ status: "offline" });
    }
  };

  // Vérification périodique
  componentDidMount() {
    this.checkUrl(); // Vérification initiale
    this.interval = setInterval(this.checkUrl, 10000); // Vérifie toutes les 10 secondes
  }

  componentWillUnmount() {
    if (this.interval) {
      clearInterval(this.interval); // Nettoie l'intervalle
    }
  }

  render() {
    const { id, title, url } = this.props;
    const { status } = this.state;

    return (
      <div className={classes.Url}>
        <div className={classes.UrlRow}>
          <div className={classes.UrlInfo}>
            {id} - <span>{title} :</span>{" "}
            <a href={url} target="_blank" rel="noreferrer">
              {url}
            </a>
          </div>
          <div className={classes.Status}>
            {status === "checking" && (
              <span style={{ color: "gray" }}>⏳</span>
            )}
            {status === "online" && (
              <span style={{ color: "green" }}>✅</span>
            )}
            {status === "offline" && (
              <span style={{ color: "red" }}>❌</span>
            )}
          </div>
        </div>
      </div>
    );
  }
}

export default Url;
