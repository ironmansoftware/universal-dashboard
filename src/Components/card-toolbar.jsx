import React from "react";
import { Toolbar, IconButton, Typography } from "@mui/material";
import withStyles from '@mui/styles/withStyles';
import classNames from "classnames";
import UdMuTypography from "./typography";
import UdMuIcon from './icon';

const styles = theme => ({
  cardToolBar: {
    display: "flex",
    alignItems: "center",
    paddingLeft: 16,
    paddingRight: 16,
    maxHeight: 56
  },
  icon: {
    marginRight: theme.spacing(2)
  },
  title: {
    flex: "1 1 auto",
    marginLeft: theme.spacing(2),
  },
  action: {
    flex: "0 0 auto"
  }
});

export class UDCardToolBar extends React.Component {

  onTitle = (classes, style, title) => {
    return (
      title.type === 'mu-typography' ?
        <UdMuTypography
          classes={classNames(classes.title, title.className, "ud-mu-cardtoolbar-title")}
          {...title} />
        : <Typography
          variant="h6"
          style={{ color: style.color, font: style.font }}
          className={classNames(classes.title, "ud-mu-cardtoolbar-title")}>
          {title}
        </Typography>
    );
  };

  render() {
    const {
      id,
      classes,
      onMinimize,
      title,
      icon,
      onShowButtons,
      style,
      content,
    } = this.props;

    return <>
      <Toolbar
        id={id}
        style={{ ...style }}
        disableGutters
        className={classNames("ud-mu-cardtoolbar", classes.cardToolBar)}
      >
        {icon !== null ? (
          <UdMuIcon className="ud-mu-cardtoolbar-icon" {...icon} />
        ) : null}
        {this.onTitle(classes, style, title)}
        {onShowButtons ? (
          <div
            className={classNames(classes.action, "ud-mu-cardtoolbar")}>
            <IconButton className="ud-mu-cardtoolbar-minimize" onClick={onMinimize} size="large">
              <UdMuIcon
                icon="Minus"
                size={content === null ? "xs" : content[0].icon.size}
                style={
                  content !== null
                    ? { ...content[0].icon.style }
                    : { color: "inherit", backgroundColor: "transparent" }
                }
              />
            </IconButton>
            {UniversalDashboard.renderComponent(content)}

          </div>
        ) : null}
      </Toolbar>
    </>;
  }
}

export default withStyles(styles)(UDCardToolBar);
