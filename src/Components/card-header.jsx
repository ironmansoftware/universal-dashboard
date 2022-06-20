import React from "react";
import CardHeader from '@mui/material/CardHeader';

const UDCardHeader = (props) => {
  return (
    <CardHeader {...props} titleTypographyProps={{ align: props.titleAlignment }} subheaderTypographyProps={{ align: props.subHeaderAlignment }} />
  )
}

export default UDCardHeader;