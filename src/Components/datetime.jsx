import React from 'react';
var dayjs = require('dayjs')
var localizedFormat = require('dayjs/plugin/localizedFormat')
var relativeTime = require('dayjs/plugin/relativeTime')
var utc = require('dayjs/plugin/utc')
dayjs.extend(relativeTime)
dayjs.extend(utc)
dayjs.extend(localizedFormat)

const DayTime = (props) => {
    if (props.format.indexOf("L") === -1 && props.format.indexOf("l") === -1) {
        return dayjs(props.inputObject).format(props.format);
    }
    else {
        return dayjs(props.inputObject).local().format(props.format);
    }
}

export default DayTime;

