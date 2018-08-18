import React from 'react';
import {Input as RInput, Row, Col, Preloader} from 'react-materialize';
import {DebounceInput} from 'react-debounce-input';

export default class UdInputField extends React.Component {
    onSelectChanged(field, e) {
        this.props.onValueChanged(field.name, e.target.value);
    }

    onRadioChanged(field, e) {
        this.props.onValueChanged(field.name, e.currentTarget.value);
    }

    onTextFieldChange(field, e) {
        this.props.onValueChanged(field.name, e.target.value);
    }

    onCheckboxChanged(field, e) {
        this.props.onValueChanged(field.name, e.target.checked);
    }

    setupDatePicker() {
        var comp = this;

        $(this.datetime).pickadate({
            selectYears: 15,
            clearText: this.props.clearText,
            okText: this.props.okText,
            cancelText: this.props.cancelText,
            closeOnSelect: true,
            onSet: function(e) {   
                // you can use any of the pickadate options here
                var val = this.get('select', 'dd-mm-yyyy');
                comp.onTextFieldChange({name: comp.props.name},  {target: {value: val}});
                // auto close on select
                this.close();
            }
        })
    }

    setupTimePicker() {
        var comp = this;

        $(this.datetime).pickatime({
            clearText: this.props.clearText,
            okText: this.props.okText,
            cancelText: this.props.cancelText,
            closeOnSelect: true,
            onSet: function(e) {   
                var val = this.get('select');
                comp.onTextFieldChange({name: comp.props.name},  {target: {value: val}});
                // auto close on select
                this.close();
            }
        })
    }

    componentDidMount() {
        if (Materialize && Materialize.updateTextFields)
        {
            Materialize.updateTextFields();
        }
        
        if (this.props.type === 'date') {
            this.setupDatePicker();
        } 

        if (this.props.type === 'time') {
            this.setupTimePicker();
        } 
    }

    componentDidUpdate() {
        if (Materialize && Materialize.updateTextFields)
        {
            Materialize.updateTextFields();
        }

        if (this.props.type === 'date') {
            this.setupDatePicker();
        } 

        if (this.props.type === 'time') {
            this.setupTimePicker();
        } 
    }

    render() {
        var field = {
            name: this.props.name,
            type: this.props.type,
            value: this.props.value,
            placeholder: this.props.placeholder,
            validOptions: this.props.validOptions
        }

        if (field.type === 'textbox' || field.type === 'password') {
            var type = field.type == 'textbox' ? 'text' : 'password';

            var textfield = null;
            if (this.props.debounceTimeout == null) {
                textfield = <input id={field.name} name={field.name} type={type} onChange={e => this.onTextFieldChange(field, e) } value={field.value}/>
            } else {
                textfield = <DebounceInput id={field.name} name={field.name} onChange={e => this.onTextFieldChange(field, e) } value={field.value} debounceTimeout={this.props.debounceTimeout}/>
            }

            return <div className="input-field">
                        {textfield}
                        <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>
                    </div>
        }

        if (field.type === 'textarea') {
            return <div className="input-field">
                        <textarea className="materialize-textarea" id={field.name} name={field.name} type="textarea" onChange={e => this.onTextFieldChange(field, e) } value={field.value}/>
                        <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>
                    </div>
        }

        if (field.type === 'checkbox') {
            return <p>
                    <input type="checkbox" id={field.name} name={field.name} onChange={e => this.onCheckboxChanged(field, e) } value={field.value}/>
                    <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>
                   </p>
        }

        if (field.type === 'date') {
            return [
                <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>,
                <input type="text"  className="datepicker" id={field.name} onChange={e => this.onTextFieldChange(field, e) } value={field.value} ref={datetime => this.datetime = datetime}/>
            ]
        }

        if (field.type == 'time') {
            return [
                <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>,
                <input type="text"  className="timepicker" id={field.name} onChange={e => this.onTextFieldChange(field, e) } value={field.value} ref={datetime => this.datetime = datetime}/>
            ]
        }

        if (field.type == 'switch') {
            var on = 'On';
            var off = 'Off';

            if (field.placeholder && field.placeholder.length === 2) {
                on = field.placeholder[0];
                off = field.placeholder[1];
            }

            return <div className="switch">
                        <label>
                            {off}
                            <input type="checkbox" id={field.name} name={field.name} onChange={e => this.onCheckboxChanged(field, e) } value={field.value}/>
                            <span className="lever"></span>
                            {on}
                        </label>
                    </div>
        }

        if (field.type == 'select') {
            var options = null;
            if (field.validOptions != null) {
                options = field.validOptions.map(function(option, i) {
                    return <option value={option}>{option}</option>
                });
            }
            
            return <RInput type='select' label={field.placeholder ? field.placeholder[0] : field.name} onChange={e => this.onSelectChanged(field, e) } defaultValue={field.value}>
                {options}
            </RInput>
        }

        if (field.type == 'radioButtons') {

            var usePlaceholder = false;
            if (field.placeholder && field.placeholder.length == field.validOptions.length) {
                usePlaceholder = true;
            }

            var self = this;

            var options = field.validOptions.map(function(option, i) {
                return <p>
                            <input name={field.name} type="radio" id={option} value={option} onChange={e => self.onRadioChanged(field, e) } />
                            <label htmlFor={option}>{usePlaceholder ? field.placeholder[i] : option}</label>
                        </p>
            });

            return options;
        }
    }
}