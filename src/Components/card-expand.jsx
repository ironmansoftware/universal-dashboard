import React, { Fragment } from "react";
import withStyles from '@mui/styles/withStyles';
import classNames from "classnames";
import { ReactInterval } from "react-interval/lib/Component";

const styles = theme => ({
  content: {
    display: "flex"
  }
});

class UDCardExpand extends React.Component {
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
            this.setState({ hasError: true, error: data.error, content: data, })
            : this.setState({ content: data, loading: false })
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
      isEndpoint,
      refreshInterval,
      autoRefresh
    } = this.props;

    const { content } = this.state;

    return (
      <Fragment>
        <div
          id={id}
          className={classNames(classes.content, className, "ud-mu-cardexpand")}
          style={{ ...style }}>
          {UniversalDashboard.renderComponent(content)}
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

export default withStyles(styles)(UDCardExpand);
