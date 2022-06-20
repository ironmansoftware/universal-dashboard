import React, { Fragment } from "react";
import { IconButton, CardActions } from "@mui/material";
import withStyles from '@mui/styles/withStyles';
import ExpandLess from "@mui/icons-material/ExpandLess";
import ExpandMore from "@mui/icons-material/ExpandMore";
import classNames from "classnames";
import { ReactInterval } from "react-interval/lib/Component";

const styles = theme => ({
  content: {
    display: "flex"
  },
  expand: {
    flex: '0 1 auto',
    marginRight: theme.spacing(),
  },
  actions: {
    flexGrow: 1,
  },
});

class UDCardFooter extends React.Component {
  state = {
    content: this.props.content,
  };

  onLoadData = () => {
    if (!this.props.isEndpoint) {
      this.setState({
        content: this.props.content
      })
    }
    else {
      UniversalDashboard.get(
        `/api/internal/component/element/${this.props.id}`, data => {
          data.error ?
            this.setState({ hasError: true, error: data.error, content: data })
            : this.setState({ content: data })
        }
      )
    }
  }

  componentWillMount = () => {
    this.onLoadData();
  }

  render() {
    const {
      className,
      classes,
      id,
      style,
      onExpand,
      isExpanded,
      isExpandExists,
      isEndpoint,
      refreshInterval,
      autoRefresh
    } = this.props;

    const { content } = this.state;

    return (
      <Fragment>
        <div
          id={id}
          className={classNames(classes.content, className, "ud-mu-cardfooter")}
          style={{ ...style }}>
          <CardActions className={classes.actions}>
            {UniversalDashboard.renderComponent(content)}
          </CardActions>
          <CardActions className={classes.expand}>
            {isExpandExists ?
              <IconButton id={'ud-card-expand-button'} onClick={onExpand} size="large">
                {isExpanded ?
                  <ExpandLess color="primary" />
                  : <ExpandMore color="primary" />}
              </IconButton>
              : null}
          </CardActions>
        </div>

        {isEndpoint ?
          <ReactInterval
            timeout={refreshInterval * 1000}
            enabled={autoRefresh}
            callback={this.onLoadData} /> : null}

      </Fragment>
    );
  }
}

export default withStyles(styles)(UDCardFooter);
