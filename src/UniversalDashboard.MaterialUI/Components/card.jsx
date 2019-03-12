import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import classNames from "classnames";
import {
  Collapse,
  Typography,
  CardContent,
  Toolbar,
  Card,
  IconButton,
  CssBaseline
} from "@material-ui/core";
import UdMuIcon from "./icon";
import ReactInterval from "react-interval";

const styles = theme => ({
  root: {
    display: "flex",
    margin: theme.spacing.unit,
    flexDirection: "column",
    flex: "1 1 auto"
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
    "&:last-child": {
      paddingBottom: 16
    },
    flex: "1 1 auto"
  }
});

const CardToolBar = withStyles(theme => ({
  cardToolBar: {
    display: "flex",
    alignItems: "center",
    paddingLeft: 16,
    paddingRight: 16,
    height: 56
  },
  icon: {
    marginRight: theme.spacing.unit * 2
  },
  title: {
    flex: "1 1 auto",
    marginLeft: 32,
    fontWeight: 600,
    fontFamily: [
      '"Roboto Condensed"',
      "Roboto",
      '"Segoe UI"',
      '"Helvetica Neue"',
      "Arial",
      "sans-serif",
      "-apple-system",
      "BlinkMacSystemFont",
      '"Apple Color Emoji"',
      '"Segoe UI Emoji"',
      '"Segoe UI Symbol"'
    ].join(",")
  },
  action: {
    flex: "0 0 auto"
  },
  reloadButton: {
    display: "none"
  }
}))(props => {
  const {
    classes,
    onMinimize,
    onReload,
    title,
    icon,
    onShowControls,
    style,
    content,
    isEndpoint
  } = props;
  return (
    <>
      <CssBaseline />
      <Toolbar
        style={{ ...style }}
        disableGutters
        id="card-tool-bar"
        className={classes.cardToolBar}
      >
        <UdMuIcon {...icon} />
        <Typography
          variant="h6"
          style={{ color: style.color }}
          className={classes.title}
        >
          {title}
        </Typography>

        {onShowControls ? (
          <div className={classes.action}>
            <IconButton onClick={onMinimize}>
              <UdMuIcon
                icon="Minus"
                size={content === null ? "sm" : content[0].icon.size}
                style={{ ...content[0].icon.style }}
              />
            </IconButton>
            <IconButton
              onClick={onReload}
              className={!isEndpoint ? classes.reloadButton : null}
            >
              <UdMuIcon
                icon="Sync"
                size={content === null ? "sm" : content[0].icon.size}
                style={{ ...content[0].icon.style }}
              />
            </IconButton>
            {content === null
              ? null
              : content.map(item => {
                  return UniversalDashboard.renderComponent(item);
                })}
          </div>
        ) : null}
      </Toolbar>
    </>
  );
});

export class UdMuCard extends React.Component {
  state = {
    expanded: false,
    minimized: false,
    elevation: 1,
    content: this.props.content,
    hasError: false,
    errorMessage: "",
    loading: true
  };

  onMinimizeClick = () => {
    this.setState(state => ({ minimized: !state.minimized }));
  };

  onMouseEnterEvent = () => {
    this.setState({
      elevation: !this.props.elevation ? 1 : this.props.elevation
    });
  };

  onMouseLeaveEvent = () => {
    this.setState({
      elevation: 1
    });
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
    console.log('OnDataLoadStateContent',this.state)
  }

  onReloadClick = () => {
    this.onLoadData();
  };

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
      size,
      style,
      showToolBar,
      toolbarStyle,
      toolbarContent,
      showControls,
      icon,
      title,
      classes,
      autoRefresh,
      refreshInterval,
      isEndpoint
    } = this.props;

    const { 
      minimized, 
      elevation, 
      content } = this.state;
    
    return (
      <>
        <CssBaseline />
        <Card
          id={this.props.id}
          elevation={elevation}
          className={classNames(classes.root, "ud-mu-card", {
            [classes.cardSmall]: size == "small" && !minimized,
            [classes.cardMedium]: size == "medium" && !minimized,
            [classes.cardLarge]: size == "large" && !minimized
          })}
          onMouseEnter={this.onMouseEnterEvent}
          onMouseLeave={this.onMouseLeaveEvent}
          style={{ ...style }}
        >
          {showToolBar ? (
            <CardToolBar
              onShowControls={showControls}
              icon={icon}
              title={title}
              onMinimize={this.onMinimizeClick}
              onReload={this.onReloadClick}
              style={toolbarStyle}
              content={toolbarContent}
              isEndpoint={isEndpoint}
            />
          ) : null}
          <Collapse
            in={!minimized}
            key={this.props.id}
            collapsedHeight={0}
            mountOnEnter
          >
            <CardContent classes={{ root: classes.content }}>
              {content !== null
                ? content.map(item => {
                    return UniversalDashboard.renderComponent(item);
                  })
                : null}
            </CardContent>
          </Collapse>
            <ReactInterval
              timeout={refreshInterval * 1000}
              enabled={autoRefresh}
              callback={this.onLoadData}
            />
        </Card>
      </>
    );
  }
}

UdMuCard.propTypes = {
  classes: PropTypes.object.isRequired,
  size: PropTypes.string,
  // content: PropTypes.array,
  style: PropTypes.object,
  showToolBar: PropTypes.bool.isRequired,
  toolbarStyle: PropTypes.object,
  toolbarContent: PropTypes.object,
  showControls: PropTypes.bool,
  icon: PropTypes.oneOfType(["UdMuIcon"]),
  title: PropTypes.string,
  autoRefresh: PropTypes.bool,
  refreshInterval: PropTypes.number
};

export default withStyles(styles)(UdMuCard);
