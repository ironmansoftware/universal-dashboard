import React from 'react';
import Link from '@mui/material/Link';
import classNames from 'classnames'
import { withComponentFeatures } from 'universal-dashboard'

const UDLink = (props) => {
	const {
		id,
		url,
		underline,
		style,
		variant,
		className,
		openInNewWindow,
		content,
		text,
		onClick
	} = props;

	return (
		<Link
			id={id}
			href={onClick ? ":" : url}
			rel="noopener"
			underline={underline}
			style={{ ...style }}
			variant={variant}
			className={classNames(className, "ud-mu-link")}
			target={openInNewWindow ? '_blank' : '_self'}
			onClick={(e) => {
				if (onClick) {
					e.preventDefault();
					onClick();
				}
			}}>
			{!text ? (UniversalDashboard.renderComponent(content)) : text}
		</Link>
	)
}

export default withComponentFeatures(UDLink);
