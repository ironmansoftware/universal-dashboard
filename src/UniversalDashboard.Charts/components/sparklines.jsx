import React from 'react';
import { Sparklines, SparklinesLine, SparklinesBars } from 'react-sparklines';

export default class UDSparklines extends React.Component {
    render() {

        var { data, limit, width, height, margin, color, sparkType, min, max } = this.props;

        if (sparkType === "lines") {
            return (
                <Sparklines data={data} limit={limit} width={width} height={height} margin={margin} min={min} max={max}>
                    <SparklinesLine color={color}></SparklinesLine>
                </Sparklines>
            )
        }

        if (sparkType === "bars") {
            return (
                <Sparklines data={data} limit={limit} width={width} height={height} margin={margin} min={min} max={max}>
                    <SparklinesBars color={color}></SparklinesBars>
                </Sparklines>
            )
        }

        if (sparkType === "both") {
            return (
                <Sparklines data={data} limit={limit} width={width} height={height} margin={margin} min={min} max={max}>
                    <SparklinesBars color={color}></SparklinesBars>
                    <SparklinesLine color={color}></SparklinesLine>
                </Sparklines>
            )
        }
    }
}