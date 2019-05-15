import React from 'react'
import { icon } from '@fortawesome/fontawesome-svg-core/index.es'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome/index.es'
import findSolidIcon from './faSolid'
import findRegularIcon from './faRegular'
import classNames from "classnames"

export default class UDIcon extends React.Component {

    constructor(props) {
        super(props)

        this.state = {
            icon: ''
        }
    }

    setFontAwesomeIcon = (faIcon) => {
        var i = null
        const name = `fa${faIcon}`
        this.props.regular && findRegularIcon(name) === true ? 
        import(`@fortawesome/free-regular-svg-icons/index.es.js`).then(({far}) => {
            let fai = icon(far[name])
            i = fai
            this.setState({
                ...this.props,
                icon: i
            })
        }) :
        findSolidIcon(name) === true ?
        import(`@fortawesome/free-solid-svg-icons/index.es.js`).then(({fas}) => {
            let fai = icon(fas[name])
            i = fai
            this.setState({
                ...this.props,
                icon: i
            })
        }) : import(`@fortawesome/free-brands-svg-icons/index.es.js`).then(({fab}) => {
            let fai = icon(fab[name])
            i = fai
            this.setState({                
                ...this.props,
                icon: i
            })

        })      
    }

    componentWillMount(){
        this.setFontAwesomeIcon(this.props.icon)
    }

    componentWillReceiveProps(newProps) {
        this.setFontAwesomeIcon(newProps.icon)
    }


    render(){
        return (
            <FontAwesomeIcon className={classNames(this.props.className, "ud-mu-icon")} {...this.props} icon={this.state.icon} data-tooltip={this.props.dataTooltip}/>
        )
    }
}