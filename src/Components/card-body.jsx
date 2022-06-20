import React, { Fragment } from "react";
import { CardContent } from "@mui/material";
import withStyles from '@mui/styles/withStyles';
import classNames from "classnames";

const styles = theme => ({
  content: {
    //display: "flex"
  }
});

export class UDCardBody extends React.Component {
  render() {
    const {
      className,
      classes,
      id,
      style
    } = this.props;

    return (
      <Fragment>
        <CardContent
          id={id}
          key={id}
          className={classNames(classes.content, className, "ud-mu-cardbody")}
          style={{ ...style }}>
          {UniversalDashboard.renderComponent(this.props.content)}
        </CardContent>
      </Fragment>
    );
  }
}

export default withStyles(styles)(UDCardBody);
