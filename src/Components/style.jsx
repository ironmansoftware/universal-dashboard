import React from 'react';
import { css } from 'emotion';
import { withComponentFeatures } from 'universal-dashboard';
import { Box } from '@mui/material';

const UDStyle = (props) => {
  var children = props.content;
  if (!Array.isArray(children)) {
    children = [children];
  }

  children = children.map(x => props.render(x));

  if (props.sx) {
    return <Box component={props.component} sx={props.sx}>{children}</Box>
  }

  const style = css(props.style);
  return React.createElement(props.tag, { className: style }, children);
}

export default withComponentFeatures(UDStyle);