import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import { Icon, Chip, Avatar } from '@material-ui/core';
import classNames from "classnames"

const styles = theme => ({
    root: {
        display: 'flex',
        justifyContent: 'center',
        flexWrap: 'wrap',
    },
    chip: {
        margin: theme.spacing.unit,
    },
    chipIcon: {
        width: 'auto',
        height: 'auto'
    }
});



export class UdChip extends React.Component {

    handleDelete() {

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + 'onDelete',
            eventName: 'onDelete',
            eventData: this.props.id
        });
    }

    handleClick() {

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + 'onClick',
            eventName: 'onClick',
            eventData: this.props.id
        });
    }

    render() {
        const { classes } = this.props;

        var avatar = null
        if (this.props.avatar) {

            switch (this.props.avatarType) {
                case "letter":
                    avatar = <Avatar>{this.props.avatar}</Avatar>
                    break;
                case "image":
                    avatar = <Avatar src={this.props.avatar} />
                    break;
                default:
                    break;
            }
        }

        return (
            <Chip
                id={this.props.id}
                avatar={avatar}
                label={this.props.label}
                clickable={this.props.clickable}
                onClick={this.props.clickable ? this.handleClick.bind(this) : null}
                onDelete={this.props.delete ? this.handleDelete.bind(this) : null}
                className={classNames(classes.chip, "ud-mu-chip")}
                style={{ ...this.props.style }}
                icon={<Icon className={classes.chipIcon}>
                    {UniversalDashboard.renderComponent(this.props.icon)}
                </Icon>}
                variant={this.props.variant}

            />
        );
    }
}

UdChip.propTypes = {
    classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(UdChip)