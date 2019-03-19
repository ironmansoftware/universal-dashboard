import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Link from '@material-ui/core/Link';
import classNames from 'classnames'

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
					className={classNames(className,classes.link, "ud-mu-link")}
					target={openInNewWindow ? '_blank' : '_self'}>
					{!text ? (UniversalDashboard.renderComponent(content)) : text}
				</Link>

		);
	}
}

UDLink.propTypes = {
  className: PropTypes.string,
  classes: PropTypes.object.isRequired,
  content: PropTypes.object,
  id: PropTypes.string,
  openInNewWindow: PropTypes.bool,
  style: PropTypes.object,
  text: PropTypes.string,
  underline: PropTypes.string,
  url: PropTypes.string,
  variant: PropTypes.string
};

export default withStyles(styles)(UDLink);
