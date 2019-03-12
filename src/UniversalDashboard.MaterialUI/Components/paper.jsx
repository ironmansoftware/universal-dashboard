import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import ReactInterval from "react-interval";

const styles = theme => ({
  root: {
    flexGrow: 1,
    display: "flex",
    padding: theme.spacing.unit * 2,
    margin: theme.spacing.unit
  }
});

export class UdPaper extends React.Component {

  state = {
    content: this.props.content,
  };

  onLoadData = () => {
    UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`,(data) =>{
      data.error ?
      this.setState({
        hasError: true,
        error: data.error,
        data: data,
        errorMessage: data.error.message
      }) :
      this.setState({
        content: data
      })
    })
  }

  componentWillMount = () => {
    
      this.onLoadData();
    
    this.pubSubToken = UniversalDashboard.subscribe(
      this.props.id,
      this.onIncomingEvent.bind(this)
    );
  };

  onIncomingEvent(eventName, event) {
    if (event.type === "syncElement") {
      this.onLoadData();
    }
  }

  componentWillUnmount() {
    UniversalDashboard.unsubscribe(this.pubSubToken);
  }

  render() {
    const { 
      classes,
      elevation,
      style,
      height,
      width,
      square,
      autoRefresh,
      refreshInterval,
      isEndpoint  
    } = this.props;
    
    const { content } = this.state;


console.log('paper-content',content)
console.log('papaer-state',this.state)
console.log('papaer-props',this.props)
    return (
      <>
      <Paper 
        id={this.props.id} 
        className={classes.root}
        elevation={elevation}
        style={{...style}}
        height={height}
        width={width}
        square={square}  
      >
        
        {content.map(element => {
          return UniversalDashboard.renderComponent(element) 
        })}

      </Paper>
      <ReactInterval
      timeout={refreshInterval * 1000}
      enabled={autoRefresh}
      callback={this.onLoadData}/>
    </>
    );
  }
}

UdPaper.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdPaper);
