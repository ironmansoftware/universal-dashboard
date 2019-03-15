import React, { Fragment } from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import classNames from "classnames";
import { Collapse, Card, CssBaseline } from "@material-ui/core";
import UDCardToolBar from "./card-toolbar";
import UDCardHeader from "./card-header";
import UDCardBody from "./card-body";
import UDCardExpand from "./card-expand";
import UDCardFooter from "./card-footer";

import ReactInterval from "react-interval";

const styles = theme => ({
  root: {
    display: "flex",
    margin: theme.spacing.unit,
    flexDirection: "column",
    flex: "1 1 auto"
  },
  content: {
    padding: 16,
    "&:last-child": {
      paddingBottom: 16
    },
    flex: "1 1 auto"
  },
  expand:{
    flexGrow: 1,
  },
  hidden: {
    display: "none"
  }
});

export class UDMuCard extends React.Component {
  state = {
    expanded: false,
    minimized: false,
    content: this.props.content,
    elevation : 1
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

  onExpandedClick = () => {
    this.setState({expanded: !this.state.expanded });
  };

  // onLoadData = () => {
  //   if(!this.props.isEndpoint){
  //     this.setState({
  //       content: this.props.content
  //     })
  //   }
  //   else{
  //     UniversalDashboard.get(
  //       `/api/internal/component/element/${this.props.id}`, data => {
  //         data.error ?
  //           (this.setState({
  //             hasError: true,
  //             error: data.error,
  //             content: data.content,
  //           }),
  //             console.log({
  //               component: "mu-card",
  //               action: "UniversalDashboard.get",
  //               status: "failed",
  //               error: data.error,
  //               content: data})
  //           )
  //           : 
  //           (this.setState({
  //             content: data.content
  //           }),
  //               console.log({
  //                 component: "mu-card",
  //                 action: "UniversalDashboard.get",
  //                 status: "success",
  //                 content: data})
  //           )
  //       }
  //     )
  //   }
  // }

  // onReloadClick = () => {
  //   this.onLoadData()
  // };

  // componentWillMount = () => {
  //     this.onLoadData()
  // }

  render() {
    const { classes, id, className, style, showToolBar } = this.props;
    const { expanded, minimized, elevation } = this.state
    const [{ toolbar, header, body, expand, footer, }] = this.state.content

    // console.log( toolbar, header, body, expand, footer)


    return (
      <Fragment>

        <CssBaseline />
        
        <Card
          id={id}
          elevation={elevation}
          className={classNames(className,classes.root, "ud-card")}
          onMouseEnter={this.onMouseEnterEvent}
          onMouseLeave={this.onMouseLeaveEvent}
          style={{ ...style }}>

          {toolbar !== null && showToolBar ?
          <UDCardToolBar
            id={toolbar.id}
            className={classNames(toolbar.className, "ud-card-toolbar", {
              [classes.hidden]: showToolBar
            })}
            onShowButtons={toolbar.showButtons}
            icon={toolbar.icon}
            title={toolbar.title}
            onMinimize={this.onMinimizeClick}
            // onReload={this.onReloadClick}
            style={toolbar.style}
            content={toolbar.content}
            // showReloadButton={isEndpoint}
            // isEndpoint={toolbar.isEndpoint}/> 
            /> : null}

          <Collapse
            in={!minimized}
            collapsedHeight={0}
            mountOnEnter>

            {header !== null ?
            <UDCardHeader
              className={classNames("ud-card-header", {
                [classes.hidden]: header.content === null
              })}
              id={header.id}
              content={header.content}
              style={header.style}
              isEndpoint={header.isEndpoint}
              refreshInterval={header.refreshInterval}
              autoRefresh={header.autoRefresh}/> : null}

            {body !== null ?
            <UDCardBody
              className={classNames("ud-card-body", {
                [classes.hidden]: body.content === null
              })}
              id={body.id}
              content={body.content}
              style={body.style}
              isEndpoint={body.isEndpoint}
              refreshInterval={body.refreshInterval}
              autoRefresh={body.autoRefresh}/> : null}
            
            {expand !== null ?
            <Collapse
              in={expanded}
              collapsedHeight={0}
              mountOnEnter>

              <UDCardExpand
                className={classNames("ud-card-expand", {
                  [classes.hidden]: expand.content === null
                })}
                id={expand.id}
                content={expand.content}
                style={expand.style}
                isEndpoint={expand.isEndpoint}
                refreshInterval={expand.refreshInterval}
                autoRefresh={expand.autoRefresh}/> 
            
            </Collapse> : null}

            {footer !== null ?
            <UDCardFooter
              className={classNames("ud-card-footer", {
                [classes.hidden]: footer.content === null
              })}
              id={footer.id}
              content={footer.content}
              isExpandExists={expand !== null}
              isExpanded={expanded}
              onExpand={this.onExpandedClick}
              style={footer.style}
              isEndpoint={footer.isEndpoint}
              refreshInterval={footer.refreshInterval}
              autoRefresh={footer.autoRefresh}/> : null}

          </Collapse>

          {/* This option was disabled until i fix the undefined error when the card is an Endpoint */}
          {/* <ReactInterval
            timeout={refreshInterval * 1000}
            enabled={autoRefresh}
            callback={this.onLoadData}/> */}

        </Card>
      
      </Fragment>
    );
  }
}

UDMuCard.propTypes = {
  classes: PropTypes.object.isRequired
  // size: PropTypes.string,
  // // content: PropTypes.array,
  // style: PropTypes.object,
  // showToolBar: PropTypes.bool.isRequired,
  // toolbarStyle: PropTypes.object,
  // toolbarContent: PropTypes.object,
  // showControls: PropTypes.bool,
  // icon: PropTypes.oneOfType(["UdMuIcon"]),
  // title: PropTypes.string,
  // autoRefresh: PropTypes.bool,
  // refreshInterval: PropTypes.number
};

export default withStyles(styles)(UDMuCard);
