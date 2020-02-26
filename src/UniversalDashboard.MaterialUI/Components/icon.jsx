/** @jsx jsx */
import React from 'react'
import classNames from "classnames"
import {jsx} from 'theme-ui'
export default class UDIcon extends React.Component {
    render(){
        return UniversalDashboard.renderComponent({
            className: classNames(this.props.className, "ud-mu-icon"),
            style: {...this.props.style},
            ...this.props,
            sx: {color: 'primary'},
            type: 'icon'
        })
    }
}