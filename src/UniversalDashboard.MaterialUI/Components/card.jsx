import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import classNames from "classnames";
import { Button, Collapse, Typography, CardContent, Toolbar,Card } from "@material-ui/core";
import UdMuIcon from "./icon";
import ReactInterval from 'react-interval';

const styles = theme => ({
  root: {
    display: "flex",
    margin: theme.spacing.unit,
    flexDirection: "column",
    flex: '1 1 auto',
  },
  cardSmall: {
    maxHeight: 300
  },
  cardMedium: {
    maxHeight: 400
  },
  cardLarge: {
    maxHeight: 500
  },
  content: {
    padding: 16,
    '&:last-child': {
      paddingBottom: 16,
    },
    flex: '1 1 auto'
  },
});

const CardToolBar = withStyles(theme => ({
    cardToolBar: {
        paddingLeft: theme.spacing.unit * 2,
        paddingRight: theme.spacing.unit * 2,
        display: "flex",
        flexDirection: "row",
        justifyContent: 'flex-end'
    },
    title:{
        weight:600,
        marginLeft: theme.spacing.unit * 2,
        fontSize: 20,
        flexGrow: 1,
      },
      icon:{
        marginLeft: theme.spacing.unit,
      },
  }))(props => {
    const { classes, onMinimize, onReload, title, icon, onShowControls, style, content } = props;
    return (
        <Toolbar style={{...style}} variant="dense" disableGutters id="card-tool-bar" className={classes.cardToolBar}>
        <UdMuIcon {...icon}/>
        <Typography variant="headline" style={{color:style.color}} className={classes.title}>{title}</Typography>
        {onShowControls  
        ? ([<Button
            color="inherit"
            disableRipple
            disableFocusRipple
            size="small"
            variant="flat"
            onClick={onMinimize}
          >
            <UdMuIcon 
                style={{fontSize:20}} 
                className={classes.icon} 
                icon="Minus" 
                size="xs" 
            />
        </Button>,
        <Button
        color="inherit"
        disableRipple
        disableFocusRipple
        size="small"
        variant="flat"
        onClick={onReload}
      >
        <UdMuIcon 
            style={{fontSize:20}} 
            className={classes.icon} 
            icon="Sync" 
            size="xs" 
        />
    </Button>]) : null}
        {content === null ? null : content.map(item =>{
            return UniversalDashboard.renderComponent(item)
        })}
      </Toolbar>
    );
  });

export class UdMuCard extends React.Component {
  state = {
    expanded: false,
    minimized: false,
    elevation: !this.props.elevation ? 1 : this.props.elevation,
    content: [],
    hasError: false, 
    errorMessage: '',
    loading: true
  };

  onMinimizeClick = () => {
    this.setState(state => ({ minimized: !state.minimized }));
  };

  onMouseEnterEvent = () => {
    this.setState({
      elevation: 24
    })
  }

  onMouseLeaveEvent = () => {
    this.setState({
      elevation: !this.props.elevation ? 1 : this.props.elevation
    })
  }

  onLoadData = () => {
    UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`,(data) =>{
      data.error ?
      this.setState({
        hasError: true,
        error: data.error,
        errorMessage: data.error.message
      }) :
      this.setState({
        content: data
      })
    })
    console.log(this.state)
  }

  onReloadClick = () => {
    this.onLoadData()
  }

  componentWillMount = () => {
    this.onLoadData()
    this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
  }


  onIncomingEvent(eventName, event) {
    if (event.type === "syncElement") {
        this.onLoadData()
    }
  } 

  componentWillUnmount() {
    UniversalDashboard.unsubscribe(this.pubSubToken);
  }

  render() {
    const { size, showToolBar,toolbarStyle, toolbarContent, showControls, icon, title, classes, autoRefresh, refreshInterval } = this.props;
    const { minimized, elevation, content } = this.state;

    return (
          <Card id={this.props.id} elevation={elevation} className={classNames(classes.root,"ud-mu-card", { 
            [classes.cardSmall]: (size == "small" && !minimized),
            [classes.cardMedium]: (size == "medium" && !minimized),
            [classes.cardLarge]: (size == "large" && !minimized) 
          })} onMouseEnter={this.onMouseEnterEvent} onMouseLeave={this.onMouseLeaveEvent}>
          {showToolBar 
          ? <CardToolBar 
                onShowControls={showControls} 
                icon={icon} 
                title={title} 
                onMinimize={this.onMinimizeClick}
                onReload={this.onReloadClick}
                style={toolbarStyle}
                content={toolbarContent}/> : null}  
              <Collapse in={!minimized} key={this.props.id} collapsedHeight={0} mountOnEnter >
                <CardContent classes={{root:classes.content}}>
                  {content !== null ? content.map(item => {
                      return UniversalDashboard.renderComponent(item)
                  }) : null}
                </CardContent>
              </Collapse>
              <ReactInterval timeout={refreshInterval * 1000} enabled={autoRefresh} callback={this.onLoadData}/>
          </Card>
    );
  }
}

UdMuCard.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdMuCard);
