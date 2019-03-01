import React from 'react'
import Icon from '@material-ui/core/Icon'
import { icon,findIconDefinition } from '@fortawesome/fontawesome-svg-core/index.es'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome/index.es'
import findSolidIcon from './faSolid'

import * as fas from '@fortawesome/free-solid-svg-icons';
import * as fab from '@fortawesome/free-brands-svg-icons';

export default class UdMuIcon extends React.Component {

    state = {
        size: this.props.size,
        border: this.props.border,
        listItem: this.props.listItem,
        fixedWidth: this.props.fixedWidth,
        inverse: this.props.inverse,
        rotation: this.props.rotation,
        flip: this.props.flip,
        spin: this.props.spin,
        pulse: this.props.pulse,
        pull: this.props.pull,
        transform: this.props.transform,
        title: this.props.title,
        // ...this.props
    }

    setFontAwesomeIcon = (faIcon) => {
        var i = null
        const name = `fa${faIcon}`
        if (findSolidIcon(name) === true) {
            let fai = icon(fas[name])
            i = fai
            this.setState({
                icon: i,
                ...this.state
            })
        } else {
            let fai = icon(fab[name])
            i = fai
            this.setState({
                icon: i,
                ...this.state
            })
        }    
    }

    componentWillMount(){
        this.setFontAwesomeIcon(this.props.icon)
    }
    render(){

        return (
        <Icon color={this.props.color} style={{width: 'auto', height: 'auto',...this.props.style}}>
            <FontAwesomeIcon {...this.state}/>
        </Icon>
        )
    }
}