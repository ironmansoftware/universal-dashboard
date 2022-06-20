import React, { useEffect } from "react";
import makeStyles from '@mui/styles/makeStyles';
import { withComponentFeatures } from "universal-dashboard";
import { FormContext } from "./form";
var classNames = require('classnames');

import Grid from '@mui/material/Grid';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Checkbox from '@mui/material/Checkbox';
import Button from '@mui/material/Button';
import Paper from '@mui/material/Paper';

const UDTransferListWithContext = (props) => {
  return (
    <FormContext.Consumer>
      {({ onFieldChange }) => (
        <UDTransferList {...props} onFieldChange={onFieldChange} />
      )}
    </FormContext.Consumer>
  );
};


const useStyles = makeStyles((theme) => ({
  root: {
    margin: 'auto',
  },
  paper: {
    width: 200,
    height: 230,
    overflow: 'auto',
  },
  button: {
    margin: theme.spacing(0.5, 0),
  },
}));

function not(a, b) {
  return a.filter((value) => b.indexOf(value) === -1);
}

function intersection(a, b) {
  return a.filter((value) => b.indexOf(value) !== -1);
}

const UDTransferList = (props) => {
  const onChange = (right) => {
    const selectedItem = props.item.filter(m => right.find(x => m.value === x) != null)
    props.setState({ selectedItem })
    if (props.onChange) {
      props.onChange(selectedItem);
    }
  }

  useEffect(() => {
    props.onFieldChange({ id: props.id, value: props.item.filter(m => props.selectedItem.find(x => x === m.value) != null) })
  }, [props.selectedItem])

  const classes = useStyles();
  const [checked, setChecked] = React.useState([]);
  const [left, setLeft] = React.useState(props.item.filter(m => props.selectedItem.find(x => x === m.value) == null).map(m => m.value));
  const [right, setRight] = React.useState(props.item.filter(m => props.selectedItem.find(x => x === m.value) != null).map(m => m.value));

  const leftChecked = intersection(checked, left);
  const rightChecked = intersection(checked, right);

  const handleToggle = (value) => () => {
    const currentIndex = checked.indexOf(value);
    const newChecked = [...checked];

    if (currentIndex === -1) {
      newChecked.push(value);
    } else {
      newChecked.splice(currentIndex, 1);
    }

    setChecked(newChecked);
  };

  const handleAllRight = () => {
    var selected = right.concat(left);
    setRight(selected);
    setLeft([]);
    onChange(selected);
  };

  const handleCheckedRight = () => {
    const selected = right.concat(leftChecked);
    setRight(selected);
    onChange(selected);
    setLeft(not(left, leftChecked));
    setChecked(not(checked, leftChecked));
  };

  const handleCheckedLeft = () => {
    setLeft(left.concat(rightChecked));
    const selected = not(right, rightChecked);
    setRight(selected);
    onChange(selected);
    setChecked(not(checked, rightChecked));
  };

  const handleAllLeft = () => {
    setLeft(left.concat(right));
    setRight([]);
    onChange([]);
  };

  const customList = (items) => (
    <Paper className={classes.paper}>
      <List dense component="div" role="list">
        {items.map((item) => {
          const value = item.value;
          const labelId = `transfer-list-item-${value}-label`;

          return (
            <ListItem key={value} role="listitem" button onClick={handleToggle(value)}>
              <ListItemIcon>
                <Checkbox
                  checked={checked.indexOf(value) !== -1}
                  tabIndex={-1}
                  disableRipple
                  inputProps={{ 'aria-labelledby': labelId }}
                />
              </ListItemIcon>
              <ListItemText id={labelId} primary={item.name} />
            </ListItem>
          );
        })}
        <ListItem />
      </List>
    </Paper>
  );

  const leftItems = props.item.filter(m => left.find(x => x === m.value) != null)
  const rightItems = props.item.filter(m => right.find(x => x === m.value) != null)

  return (
    <Grid
      container
      spacing={2}
      justifyContent="center"
      alignItems="center"
      className={classNames(classes.root, props.className)}
    >
      <Grid item>{customList(leftItems)}</Grid>
      <Grid item>
        <Grid container direction="column" alignItems="center">
          <Button
            variant="outlined"
            size="small"
            className={classes.button}
            onClick={handleAllRight}
            disabled={left.length === 0}
            aria-label="move all right"
          >
            ≫
          </Button>
          <Button
            variant="outlined"
            size="small"
            className={classes.button}
            onClick={handleCheckedRight}
            disabled={leftChecked.length === 0}
            aria-label="move selected right"
          >
            &gt;
          </Button>
          <Button
            variant="outlined"
            size="small"
            className={classes.button}
            onClick={handleCheckedLeft}
            disabled={rightChecked.length === 0}
            aria-label="move selected left"
          >
            &lt;
          </Button>
          <Button
            variant="outlined"
            size="small"
            className={classes.button}
            onClick={handleAllLeft}
            disabled={right.length === 0}
            aria-label="move all left"
          >
            ≪
          </Button>
        </Grid>
      </Grid>
      <Grid item>{customList(rightItems)}</Grid>
    </Grid>
  );
};

export default withComponentFeatures(UDTransferListWithContext);
