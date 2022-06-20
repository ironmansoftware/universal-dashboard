import React, { useEffect } from 'react'
import { Checkbox } from '@mui/material'

const SelectCheckBox = React.forwardRef(
	({ indeterminate, onRowSelection, singleSelection, toggleAllRowsSelected, onChange: initialOnChange,  ...rest }, ref) => {
		const defaultRef = React.useRef()
		const resolvedRef = ref || defaultRef

		React.useEffect(() => {
			resolvedRef.current.indeterminate = indeterminate
		}, [resolvedRef, indeterminate])

		function onChange(event, checked) {
			if (singleSelection)
			{
				toggleAllRowsSelected(false);
			}

			rest.row.toggleRowSelected()
			if (onRowSelection) {
				onRowSelection({ id: rest.row.id, ...rest.row.values, selected: !rest.row.isSelected })
			}
		}
		
		return <Checkbox ref={resolvedRef} onChange={onChange} {...rest}/>
	}
)

const SelectAllCheckBox = React.forwardRef(
	({ indeterminate, onRowSelection, onChange, ...rest }, ref) => {
		const defaultRef = React.useRef()
		const resolvedRef = ref || defaultRef

		React.useEffect(() => {
			resolvedRef.current.indeterminate = indeterminate
		}, [resolvedRef, indeterminate])

		function onChangeSelection(event, checked) {
			onChange(event, checked);
			if (onRowSelection) {
				onRowSelection({ id: 'all', selected: checked })
			}
		}

		return <Checkbox ref={resolvedRef} {...rest} onChange={onChangeSelection}/>
	}
)

export { SelectCheckBox, SelectAllCheckBox }