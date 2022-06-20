import React from 'react'
import { Alert, AlertTitle } from '@mui/material';

export default function AlertCard({ error }) {
	return (
		<Alert severity='error'>
			<AlertTitle>Error</AlertTitle>
			{error.message}
		</Alert>
	)
}
