import React from 'react'
import Menu from '@mui/material/Menu'
import MenuItem from '@mui/material/MenuItem'
import SaveAltIcon from '@mui/icons-material/SaveAlt'
import { downloadJson } from '../utilities/utils'
import { Divider, IconButton, InputBase, TextField, useTheme } from '@mui/material';

import makeStyles from '@mui/styles/makeStyles';

const useStyles = makeStyles((theme) => ({
	input: {
		marginLeft: theme.spacing(0),
		flex: 1,
	},
}))

export default function ExportButton({
	exportData,
	exportFileName,
	setExportFileName,
	textOption,
	exportOption
}) {
	const classes = useStyles()
	const [anchorEl, setAnchorEl] = React.useState(null)

	function handleClick(event) {
		setAnchorEl(event.currentTarget)
	}

	function handleClose() {
		setAnchorEl(null)
		setExportFileName('')
	}

	return (
		<div>
			{textOption.export}
			<IconButton
				aria-controls='export-menu'
				aria-haspopup='true'
				onClick={handleClick}
				size="large">
				<SaveAltIcon />
			</IconButton>
			<Menu
				id='export-menu'
				anchorEl={anchorEl}
				keepMounted
				open={Boolean(anchorEl)}
				onClose={handleClose}
			>
				{
					exportOption.indexOf("CSV") === -1 ? <React.Fragment /> : [<MenuItem
						// disabled={!exportFileName}
						onClick={() => {
							exportData('csv', true)
							handleClose()
						}}
					>
						{textOption.exportAllCsv}
					</MenuItem>,
					<Divider style={{ width: '100%' }} />,
					<MenuItem
						// disabled={!exportFileName}
						onClick={() => {
							exportData('csv', false)
							handleClose()
						}}
					>
						{textOption.exportCurrentViewCsv}
					</MenuItem>,
					<Divider style={{ width: '100%' }} />]
				}

				{
					exportOption.indexOf("XLSX") === -1 ? <React.Fragment /> : [
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('xlsx', true)
								handleClose()
							}}
						>
							{textOption.exportAllXlsx}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />,
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('xlsx', false)
								handleClose()
							}}
						>
							{textOption.exportCurrentViewXlsx}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />
					]
				}

				{
					exportOption.indexOf("PDF") === -1 ? <React.Fragment /> : [
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('pdf', true)
								handleClose()
							}}
						>
							{textOption.exportAllPdf}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />,
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('pdf', false)
								handleClose()
							}}
						>
							{textOption.exportCurrentViewPdf}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />
					]
				}

				{
					exportOption.indexOf("JSON") === -1 ? <React.Fragment /> : [
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('json', true)
								handleClose()
							}}
						>
							{textOption.exportAllJson}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />,
						<MenuItem
							// disabled={!exportFileName}
							onClick={() => {
								exportData('json', false)
								handleClose()
							}}
						>
							{textOption.exportCurrentViewJson}
						</MenuItem>,
						<Divider style={{ width: '100%' }} />
					]
				}

				<MenuItem disableRipple={true}>
					<TextField
						autoFocus={true}
						variant="outlined"
						label={textOption.exportFileName}
						className={classes.input}
						value={exportFileName}
						defaultValue="data"
						size="small"
						// placeholder='file name'
						onChange={(event) =>
							setExportFileName(event.target.value)
						}
					/>
				</MenuItem>
			</Menu>
		</div>
	);
}