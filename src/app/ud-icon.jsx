import React from 'react'
import classNames from "classnames"

import { library } from '@fortawesome/fontawesome-svg-core'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

import brands from './fontawesome.brands'
import regular from './fontawesome.regular'
import solid from './fontawesome.solid'

library.add(far, fab, fas)

const UDIcon = (props) => {

    var lookup = Array.isArray(props.icon) ? props.icon[0] : props.icon;
    var iconName = Array.isArray(props.icon) ? props.icon[0] : props.icon;
    iconName = iconName.match(/[A-Z]+(?![a-z])|[A-Z]?[a-z]+|\d+/g).join('-').toLowerCase();

    var icon;
    if (regular.find(x => x === lookup)) {
        icon = ["far", iconName]
    }
    else if (solid.find(x => x === lookup)) {
        icon = ["fas", iconName]
    }
    else if (brands.find(x => x === lookup)) {
        icon = ["fab", iconName]
    } else {
        icon = ["far", 'questionCircle']
    }

    return (
        <FontAwesomeIcon className={classNames(props.className, "ud-mu-icon")} {...props} icon={icon} data-tooltip={props.dataTooltip} />
    )
}
export default UDIcon;