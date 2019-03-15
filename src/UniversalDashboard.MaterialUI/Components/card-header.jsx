import React, { Fragment } from "react";
import { CssBaseline } from "@material-ui/core";
import { ReactInterval } from "react-interval/lib/Component";

export default class UDCardHeader extends React.Component {
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
                component: "mu-card-header",
                action: "UniversalDashboard.get",
                status: "failed",
                error: data.error,
                content: data})
            ]
            : 
            [this.setState({content: data,loading: false}),
                console.log({
                  component: "mu-card-header",
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

        <div
          id={id}
          className={className}
          style={{ ...style }}>
          {UniversalDashboard.renderComponent(content)}
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

