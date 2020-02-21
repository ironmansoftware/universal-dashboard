import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Link from '@material-ui/core/Link';
import classNames from 'classnames'

const useStyles = makeStyles(theme => {
	link: {
		margin: theme.spacing.unit
	}
});

const UDLink = (props) => {
	const classes = useStyles();

	const {
		id,
		url,
		underline,
		style,
		variant,
		className,
		openInNewWindow,
		content,
		text
	} = props;

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
	)
}

export default UDLink;
