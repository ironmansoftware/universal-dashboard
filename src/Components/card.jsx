import React from "react";
import PropTypes from "prop-types";
import withStyles from '@mui/styles/withStyles';
import classNames from "classnames";
import { Collapse, Card } from "@mui/material";
import UDCardToolBar from "./card-toolbar";
import UDCardHeader from "./card-header";
import UDCardBody from "./card-body";
import UDCardExpand from "./card-expand";
import UDCardFooter from "./card-footer";
import UDCardMedia from './card-media';

const styles = theme => ({
  root: {
    display: "flex",
    margin: theme.spacing(),
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
  expand: {
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
    elevation: 1
  };

  onMinimizeClick = () => {
    this.setState(state => ({ minimized: !state.minimized }));
  };

  onExpandedClick = () => {
    this.setState(state => ({ expanded: !state.expanded }));
  };

  render() {
    const { classes, id, className, style, showToolBar, toolbar, header, body, expand, footer, media } = this.props;
    const { expanded, minimized, elevation } = this.state

    return (
      <Card
        id={id}
        elevation={elevation}
        className={classNames(className, classes.root, "ud-mu-card")}
        style={{ ...style }}
      >

        {toolbar !== null && showToolBar ?
          <UDCardToolBar
            id={toolbar.id}
            className={classNames(toolbar.className, {
              [classes.hidden]: showToolBar
            })}
            onShowButtons={toolbar.showButtons}
            icon={toolbar.icon}
            title={toolbar.title}
            onMinimize={this.onMinimizeClick}
            style={toolbar.style}
            content={toolbar.content}
          /> : null}

        <Collapse
          in={!minimized}
          collapsedSize={0}
          mountOnEnter>

          {header !== null ? <UDCardHeader {...header} /> : null}
          {media !== null ? <UDCardMedia {...media} /> : null}

          {body !== null ?
            <UDCardBody
              className={classNames(body.className, {
                [classes.hidden]: body.content === null
              })}
              id={body.id}
              content={body.content}
              style={body.style}
              isEndpoint={body.isEndpoint}
              refreshInterval={body.refreshInterval}
              autoRefresh={body.autoRefresh} /> : null}

          {expand !== null ?
            <Collapse
              in={expanded}
              collapsedSize={0}
              mountOnEnter>

              <UDCardExpand
                className={classNames(expand.className, {
                  [classes.hidden]: expand.content === null
                })}
                id={expand.id}
                content={expand.content}
                style={expand.style}
                isEndpoint={expand.isEndpoint}
                refreshInterval={expand.refreshInterval}
                autoRefresh={expand.autoRefresh} />

            </Collapse> : null}

          {footer !== null ?
            <UDCardFooter
              className={classNames(footer.className, {
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
              autoRefresh={footer.autoRefresh} /> : null}

        </Collapse>
      </Card>
    );
  }
}

UDMuCard.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UDMuCard);
