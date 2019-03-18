import React, { Fragment } from "react";
import { withStyles, CssBaseline, CardContent } from "@material-ui/core";
import classNames from "classnames";
import { ReactInterval } from "react-interval/lib/Component";

const styles = theme => ({
  content: {
    display: "flex"
  }
});

export class UDCardBody extends React.Component {
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
            [this.setState({hasError: true,error: data.error,content: data,}),
              console.log({
                component: "mu-card-body",
                action: "UniversalDashboard.get",
                status: "failed",
                error: data.error,
                content: data})
            ]
            : 
            [this.setState({content: data,loading: false}),
                console.log({
                  component: "mu-card-body",
                  action: "UniversalDashboard.get",
                  status: "success",
                  content: data})
            ]
        }
      )
    }
  }

  componentWillMount = () => {
    this.onLoadData
  }

  render() {
    const {
      className,
      classes,
      id,
      style,
      isEndpoint,
      refreshInterval,
      autoRefresh
    } = this.props;

    const { content } = this.state;

    return (
      <Fragment>
        <CssBaseline />

        <CardContent
          id={id}
          className={classNames(classes.content, className)}
          style={{ ...style }}>
          {UniversalDashboard.renderComponent(content)}
        </CardContent>
        
        {isEndpoint ? 
          <ReactInterval
            timeout={refreshInterval * 1000}
            enabled={autoRefresh}
            callback={this.onLoadData}/> : null}
      </Fragment>
    );
  }
}

export default withStyles(styles)(UDCardBody);
