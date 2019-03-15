import React, { Fragment } from "react";
import { withStyles, CssBaseline, IconButton, CardActions } from "@material-ui/core";
import ExpandLess from "@material-ui/icons/ExpandLess";
import ExpandMore from "@material-ui/icons/ExpandMore";
import classNames from "classnames";
import { ReactInterval } from "react-interval/lib/Component";

const styles = theme => ({
  content: {
    display: "flex"
  },
  expand:{
    flex: '0 1 auto',
    marginRight: theme.spacing.unit,
  },
  actions:{
    flexGrow: 1,
  },
});

class UDCardFooter extends React.Component {
  state = {
    content: this.props.content,
  };

  onLoadData = () => {
    if(!this.props.isEndpoint){
      this.setState({
        content: this.props.content
      })
    }
    else{
      UniversalDashboard.get(
        `/api/internal/component/element/${this.props.id}`, data => {
        data.error ?
            (this.setState({hasError: true,error: data.error,content: data,}),
              console.log({
                component: "mu-card-footer",
                action: "UniversalDashboard.get",
                status: "failed",
                error: data.error,
                content: data})
            )
            : 
            (this.setState({content: data}),
                console.log({
                  component: "mu-card-footer",
                  action: "UniversalDashboard.get",
                  status: "success",
                  content: data})
            )
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
        <CssBaseline />

        <div
          id={id}
          className={classNames(classes.content, className)}
          style={{ ...style }}>
          <CardActions className={classes.actions}>
            {UniversalDashboard.renderComponent(content)}
          </CardActions>
          <CardActions className={classes.expand}>
            {isExpandExists ?
                <IconButton onClick={onExpand}>
                  {isExpanded ? 
                    <ExpandLess color="primary" />
                    :<ExpandMore color="primary" />}
                </IconButton>
            : null}
          </CardActions>
        </div>

        {isEndpoint ? 
          <ReactInterval
            timeout={refreshInterval * 1000}
            enabled={autoRefresh}
            callback={this.onLoadData}/> : null}

      </Fragment>
    );
  }
}

export default withStyles(styles)(UDCardFooter);
