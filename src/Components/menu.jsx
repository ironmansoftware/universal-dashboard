import React from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import Button from '@mui/material/Button';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
import Typography from '@mui/material/Typography';
import UDIcon from './icon';

function UDMenu(props) {
    const [anchorEl, setAnchorEl] = React.useState(null);

    const onChange = (value) => {
        setAnchorEl(null);
        props.setState({ value });

        if (props.onChange) {
            props.onChange(value)
        }
    }

    const handleClick = (event) => {
        setAnchorEl(event.currentTarget);
    };

    const handleClose = () => {
        setAnchorEl(null);
    };

    let children = props.children;
    if (!children) { children = [] }
    if (!Array.isArray(children)) { children = [children] }

    let icon;
    if (props.icon) {
        icon = <UDIcon {...props.icon} />
    }

    return (
        <div>
            <Button aria-controls="simple-menu" aria-haspopup="true" onClick={handleClick} variant={props.variant}>
                {icon}
                {props.text}
            </Button>
            <Menu
                id={props.id}
                anchorEl={anchorEl}
                keepMounted
                open={Boolean(anchorEl)}
                onClose={handleClose}
            >
                {children.map(child => <UDMenuItem key={child.value} {...child} onClick={onChange} />)}
            </Menu>
        </div>
    );
}

function UDMenuItem(props) {
    let icon;
    if (props.icon) {
        icon = <UDIcon {...props.icon} />
    }

    return (
        <MenuItem onClick={() => props.onClick(props.value)}>
            {icon}
            <Typography variant="inherit">{props.text}</Typography>
        </MenuItem>
    )
}

export default withComponentFeatures(UDMenu);

