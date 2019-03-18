import React from "react";
import {
  withStyles,
  CssBaseline,
  Toolbar,
  IconButton,
  Typography
} from "@material-ui/core";
import classNames from "classnames";
import UdMuIcon from "./icon";
import UdMuTypography from "./typography";

const styles = theme => ({
  cardToolBar: {
    display: "flex",
    alignItems: "center",
    paddingLeft: 16,
    paddingRight: 16,
    maxHeight: 56
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
      "sans-serif"
    ].join(",")
  },
  action: {
    flex: "0 0 auto"
  },
  reloadButton: {
    display: "none"
  }
});

export class UDCardToolBar extends React.Component {
  
  onTitleText = (classes, style, title) => {
    return (
      <Typography
        variant="h6"
        style={{ color: style.color }}
        className={classNames("ud-card-toolbar-title-basic", classes.title)}
      >
        {title}
      </Typography>
    );
  };

  onTitleComponent = (classes, title) => {
    return (
      <UdMuTypography
        classes={classNames(
          "ud-card-toolbar-title",
          classes.title,
          title.className
        )}
        {...title}
      />
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

    return (
      <>
        <CssBaseline />
        <Toolbar
          id={id}
          style={{ ...style }}
          disableGutters
          className={classNames("ud-card-toolbar", classes.cardToolBar)}
        >
          {icon !== null ? (
            <UdMuIcon className="ud-card-toolbar-icon" {...icon} />
          ) : null}
          {!title.type
            ? this.onTitleText(classes, style, title)
            : this.onTitleComponent(classes, title)}

          {onShowButtons ? (
            <div
              className={classNames(
                classes.action,
                "ud-card-toolbar-buttons-wrapper"
              )}
            >
              <IconButton
                className="ud-card-toolbar-button-minimize"
                onClick={onMinimize}
              >
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
      </>
    );
  }
}

export default withStyles(styles)(UDCardToolBar);
