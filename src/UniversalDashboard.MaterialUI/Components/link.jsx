import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Link from '@material-ui/core/Link';
import classnames from 'classnames'

const styles = (theme) => ({
	link: {
		margin: theme.spacing.unit
	}
});

export class UDLink extends React.Component {
	render() {
		const {
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
		const body = !text ? UniversalDashboard.renderComponent(content) : text;

		return (
			<Link
				href={url}
				rel="noopener"
				underline={underline}
				style={{ ...style }}
				variant={variant}
				className={classnames("ud-link",className,classes.link)}
				target={openInNewWindow ? '_blank' : '_self'}>
				{body}
			</Link>
		);
	}
}

UDLink.propTypes = {
	classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UDLink);
