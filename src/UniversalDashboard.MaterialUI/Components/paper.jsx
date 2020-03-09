/** @jsx jsx */
import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import ReactInterval from "react-interval";
import classNames from "classnames"
import {jsx} from 'theme-ui'
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
    children: this.props.children,
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
        children: data
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

  UNSAFE_componentWillUnmount() {
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
      refreshInterval
    } = this.props;
    
    const { children } = this.state;

    return (
      <>
      <Paper 
        id={this.props.id} 
        className={classNames(classes.root, "ud-mu-paper")}
        elevation={elevation}
        style={{...style}}
        height={height}
        width={width}
        square={square}  
        sx={{ bg: 'primary', color: 'text'}}
      >
        
        {UniversalDashboard.renderComponent(children)}

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
