import React from 'react';
import { Sparklines, SparklinesBars } from 'react-sparklines';

export default class UDSparkline extends React.Component {
    render() {
      return (
        <Sparklines data={this.props.Data} limit={10} >
            <SparklinesBars color={this.props.Color} />
        </Sparklines>
      );
    }
}

