import React from 'react'
import { icon } from '@fortawesome/fontawesome-svg-core/index.es'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome/index.es'
import findSolidIcon from './faSolid'
import findRegularIcon from './faRegular'
import classNames from "classnames"

export default class UDIcon extends React.Component {

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
        id: this.props.id,
    }

    setFontAwesomeIcon = (faIcon) => {
        var i = null
        const name = `fa${faIcon}`
        this.props.regular && findRegularIcon(name) === true ? 
        import(`@fortawesome/free-regular-svg-icons/index.es.js`).then(({far}) => {
            let fai = icon(far[name])
            i = fai
            this.setState({
                icon: i,
                ...this.state
            })
        }) :
        findSolidIcon(name) === true ?
        import(`@fortawesome/free-solid-svg-icons/index.es.js`).then(({fas}) => {
            let fai = icon(fas[name])
            i = fai
            this.setState({
                icon: i,
                ...this.state
            })
        }) : import(`@fortawesome/free-brands-svg-icons/index.es.js`).then(({fab}) => {
            let fai = icon(fab[name])
            i = fai
            this.setState({
                icon: i,
                ...this.state
            })

        })      
    }

    componentWillMount(){
        this.setFontAwesomeIcon(this.props.icon)
    }
    render(){
        return (
            <FontAwesomeIcon className={classNames(this.props.className, "ud-mu-icon")} style={{...this.props.style}} {...this.state}/>
        )
    }
}