import React from 'react'
import classNames from "classnames"

export default class UDIcon extends React.Component {
    render(){
        return UniversalDashboard.renderComponent({
            className: classNames(this.props.className, "ud-mu-icon"),
            style: {...this.props.style},
            ...this.props,
            type: 'icon'
        })
    }
}