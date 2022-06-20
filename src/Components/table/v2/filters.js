import React, { useState } from 'react'
import { format } from './utilities';

import { MenuItem, InputBase, Slider, Select, darken, lighten } from '@mui/material';

import withStyles from '@mui/styles/withStyles';

import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';

import AdapterDateFns from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';
import DatePicker from '@mui/lab/DatePicker';

import { matchSorter } from 'match-sorter'

const CustomInput = withStyles((theme) => ({
	root: {},
	input: {
		borderRadius: 4,
		position: 'relative',
		backgroundColor:
			theme.palette.mode === 'light'
				? darken(theme.palette.background.paper, 0.1)
				: lighten(theme.palette.background.paper, 0.2),
		fontSize: 14,
		// border: `1px solid ${darken(theme.palette.background.paper, 0.75)}`,
		padding: '5px 6px 5px 6px',
		transition: theme.transitions.create(['border-color', 'box-shadow']),
		'&:focus': {
			borderRadius: 4,
		},
	},
}))(InputBase)

const CustomSlider = withStyles((theme) => ({
	root: {
		color: theme.palette.primary.main,
		// height: 8,
	},
	thumb: {
		height: 16,
		width: 16,
		backgroundColor: theme.palette.primary.main,
		border: '2px solid currentColor',
		marginTop: -7,
		marginLeft: -12,
		'&:focus, &:hover, &$active': {
			boxShadow: 'inherit',
		},
	},
	active: {},
	valueLabel: {
		left: 'calc(-50% - 3px)',
	},
	track: {
		height: 4,
		borderRadius: 2,
		backgroundColor: theme.palette.primary.main,
	},
	rail: {
		height: 4,
		borderRadius: 2,
		backgroundColor: theme.palette.primary.light,
	},
}))(Slider)

export function SelectColumnFilter({
	column: { filterValue, setFilter, preFilteredRows, id },
}) {
	const options = React.useMemo(() => {
		const options = new Set()
		preFilteredRows.filter(x => x != null).forEach((row) => {
			options.add(row.values[id])
		})
		return [...options.values()]
	}, [id, preFilteredRows])

	return (
		<Select
			value={filterValue}
			onChange={(e) => {
				setFilter(e.target.value || undefined)
			}}
			input={<CustomInput />}
			fullWidth={true}
		>
			<MenuItem value=''>All</MenuItem>
			{options.sort(function (a, b) {
				return ('' + a).localeCompare(b);
			}).map((option, i) => (
				<MenuItem key={i} value={option}>
					{option}
				</MenuItem>
			))}
		</Select>
	)
}

export function AutoCompleteColumnFilter({
	column: { filterValue, setFilter, preFilteredRows, id },
}) {
	const options = React.useMemo(() => {
		const options = new Set()
		preFilteredRows.forEach((row) => {
			options.add(row.values[id])
		})
		return [...options.values()]
	}, [id, preFilteredRows])

	const sortedOptions = options.filter(x => x != null).sort(function (a, b) {
		return ('' + a).localeCompare(b);
	});

	return (
		<Autocomplete
			value={filterValue}
			onChange={(e, newValue) => {
				setFilter(newValue);
			}}
			options={sortedOptions}
			renderInput={(params) => <TextField {...params} />}
		/>
	)
}

export function DateColumnFilter({
	column: { filterValue, setFilter, preFilteredRows, id },
}) {

	return (
		<LocalizationProvider dateAdapter={AdapterDateFns}>
			<DatePicker
				disableToolbar
				clearable
				variant="dialog"
				format="MM/dd/yyyy"
				margin="normal"
				label="Filter Date"
				value={filterValue}
				onChange={(e, newValue) => {
					setFilter(newValue);
				}}
				KeyboardButtonProps={{
					'aria-label': 'change date',
				}}
			/>
		</LocalizationProvider>
	)
}


// This is a custom filter UI that uses a
// slider to set the filter value between a column's
// min and max values
export function SliderColumnFilter({
	column: { filterValue, setFilter, preFilteredRows, id, width },
}) {
	function onChange(event, newValue) {
		setFilter(parseInt(newValue))
	}
	const [min, max] = React.useMemo(() => {
		let min = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		let max = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		preFilteredRows.filter(x => x.values[id] != null).forEach((row) => {
			min = Math.min(row.values[id], min)
			max = Math.max(row.values[id], max)
		})
		return [min, max]
	}, [id, preFilteredRows])
	return (
		<CustomSlider
			style={{ width: width || undefined }}
			value={filterValue || min}
			min={min}
			max={max}
			onChange={(event, value) => onChange(event, value)}
			valueLabelDisplay='auto'
		/>
	)
}

export function NumberRangeColumnFilter({
	column: { filterValue = [], preFilteredRows, setFilter, id, width },
}) {
	const [value, setValue] = useState(() => {
		let min = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		let max = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		preFilteredRows.filter(x => x.values[id] != null).forEach((row) => {
			min = Math.min(row.values[id], min)
			max = Math.max(row.values[id], max)
		})
		return [min, max]
	})

	const [min, max] = React.useMemo(() => {
		let min = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		let max = preFilteredRows.length ? preFilteredRows[0].values[id] : 0
		preFilteredRows.filter(x => x.values[id] != null).forEach((row) => {
			min = Math.min(row.values[id], min)
			max = Math.max(row.values[id], max)
		})
		return [min, max]
	}, [id, preFilteredRows])

	function onChange(event, newValue) {
		setFilter(newValue)
	}

	return (
		<CustomSlider
			style={{ width: width || undefined }}
			value={filterValue.length < 1 ? value : filterValue}
			min={min}
			max={max}
			onChange={(event, value) => onChange(event, value)}
			valueLabelDisplay='auto'
		/>
	)
}

// Define a custom filter filter function!
export function filterGreaterThan(rows, id, filterValue) {
	return rows.filter((row) => {
		const rowValue = row.values[id]
		return rowValue >= filterValue
	})
}

// This is an autoRemove method on the filter function that
// when given the new filter value and returns true, the filter
// will be automatically removed. Normally this is just an undefined
// check, but here, we want to remove the filter if it's not a number
filterGreaterThan.autoRemove = (val) => typeof val !== 'number'

// Define a default UI for filtering
export function DefaultColumnFilter({
	textOption,
	rowCount,
	column: { filterValue, preFilteredRows, setFilter },
}) {

	var count = rowCount;
	if (rowCount == 0 && preFilteredRows.length > 0) {
		count = React.useMemo(() => preFilteredRows.length, [preFilteredRows])
	}

	return (
		<CustomInput
			value={filterValue || ''}
			onChange={(e) => {
				setFilter(e.target.value) // Set undefined to remove the filter entirely
			}}
			placeholder={format(textOption.filterSearch, count)}
		/>
	)
}

export function dateFilterFn(rows, id, filterValue) {
	if (filterValue === '' || !filterValue) {
		return rows;
	}

	var date = new Date(filterValue);

	return rows.filter((row) => {
		const rowValue = new Date(row.values[id])
		return rowValue.getDate() == date.getDate()
	})
}

export function fuzzyTextFilterFn(rows, id, filterValue) {
	return matchSorter(rows, filterValue, { keys: [(row) => row.values[id]] })
}

// Let the table remove the filter if the string is empty
fuzzyTextFilterFn.autoRemove = (val) => !val