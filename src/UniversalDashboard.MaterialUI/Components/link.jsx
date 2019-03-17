import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Link from '@material-ui/core/Link';
import classnames from 'classnames'
import { Typography } from '@material-ui/core';

const styles = (theme) => ({
	link: {
		margin: theme.spacing.unit
	}
});

export class UDLink extends React.Component {
	render() {
		const {
			id,
			url,
			underline,
			style,
			variant,
            classes,
            className,
			openInNewWindow,
			content,
			text
		} = this.props;


		return (
			
				<Link
					id={id}
					href={url}
					rel="noopener"
					underline={underline}
					style={{ ...style }}
					variant={variant}
					className={classnames(className,classes.link, "ud-link")}
					target={openInNewWindow ? '_blank' : '_self'}>
					{!text ? (UniversalDashboard.renderComponent(content)) : text}
				</Link>

			
		);
	}
}

UDLink.propTypes = {
	classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UDLink);
