import React from 'react';
import {Select, DatePicker, TimePicker, TextInput, Textarea, Checkbox, Switch, RadioGroup} from 'react-materialize';
import M from 'materialize-css';

export default class UdInputField extends React.Component {

    constructor() {
        super();

        this.state = {
            file: ''
        }
    }

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

    onFileChanged(field, e) {
        var file = e.target;
        this.props.onValueChanged(field.name, file.files[0]);
        this.setState({ file: file.files[0].name });
    }

    onValidateField(field, e) {
        if (!this.props.validate) return;

        if (this.props.required && (!e.target.value || e.target.value === "")) {
            this.props.onValidateComplete(field.name, `${field.name} is required.`);
            return;
        }

        this.props.onValidating(field.name);

        UniversalDashboard.post(`/api/internal/component/input/validate/${field.validationEndpoint}/${field.name}`, e.target.value, function(result) {
            if (result.error != null) {

                var message = this.props.validationErrorMessage;
                if (!message || message === "") {
                    message = result.error.message;
                }

                this.props.onValidateComplete(field.name, message);
            }
            else 
            {
                this.props.onValidateComplete(field.name);
            }
        }.bind(this))
    }

    componentDidUpdate() {
        var elems = document.querySelectorAll('.tooltipped');
        M.Tooltip.init(elems);
    }

    onKeyDown(e) {
        if (e.keyCode == 13) { this.props.onEnter(e); }
    }

    render() {
        var field = {
            name: this.props.name,
            type: this.props.type,
            value: this.props.value,
            placeholder: this.props.placeholder,
            validOptions: this.props.validOptions,
            validating: this.props.validating,
            validationError: this.props.validationError,
            validationEndpoint: this.props.validationEndpoint
        }

        if (field.type === 'textbox' || field.type === 'password') {
            var validationIcon = null;
            if (this.props.validating) {

                validationIcon = UniversalDashboard.renderComponent({
                    type: 'icon',
                    icon: 'CircleNotch',
                    spin: true,
                    className: 'green-text prefix tooltipped',
                    dataTooltip: 'Validating...',
                    key: field.name + "icon"
                })
            }
            else if (this.props.validationError != null) {

                validationIcon = UniversalDashboard.renderComponent({
                    id: field.name + "tooltip",
                    type: 'ud-tooltip',
                    tooltipType: 'error',
                    effect: 'solid',
                    tooltipContent: this.props.validationError,
                    className: 'prefix',
                    content: {
                        type: 'icon',
                        icon: 'TimesCircle',
                        className: 'red-text',
                        key: field.name + "icon"
                    }
                })
            }

            return <TextInput 
                className="ud-input"
                key={field.name}
                icon={validationIcon}
                password={field.type === 'password'}  
                id={field.name} name={field.name} 
                onChange={e => this.onTextFieldChange(field, e) } 
                value={field.value} 
                onBlur={e => this.onValidateField(field, e)} 
                onKeyDown={this.onKeyDown.bind(this)}  
                label={field.placeholder ? field.placeholder[0] : field.name}
            />
        }

        if (field.type === 'textarea') {
            return <Textarea 
                className="ud-input"
                id={field.name}
                name={field.name}
                onChange={e => this.onTextFieldChange(field, e) } 
                value={field.value}  
                label={field.placeholder ? field.placeholder[0] : field.name}
            />
        }

        if (field.type === 'checkbox') {

            var value = false;
            if (field.value) {
                value = String(field.value).toLowerCase() === "true";
            }

            return <Checkbox id={field.name} name={field.name} onChange={e => this.onCheckboxChanged(field, e) } checked={value} label={field.placeholder ? field.placeholder[0] : field.name} />
        }

        if (field.type === 'date') {
            var options = {
                selectYears: 100,
                clearText: this.props.clearText,
                okText: this.props.okText,
                cancelText: this.props.cancelText,
                closeOnSelect: true
            };

            return [
                <label 
                    id={field.name + 'label'} 
                    htmlFor={field.name} 
                    style={{color: this.props.fontColor}}
                    className="ud-input">{field.placeholder ? field.placeholder[0] : field.name}</label>,
                <DatePicker  
                    className="ud-input"
                    options={options} onChange={function(e) {  
                        const moment = require('moment');
                        let m = moment(e);

                        var val = m.format('DD-MM-YYYY')
                        this.onTextFieldChange({name: field.name},  {target: {value: val}});
                }.bind(this)} id={field.name}/>
            ]
        }

        if (field.type == 'time') {

            var options = {
                clearText: this.props.clearText,
                okText: this.props.okText,
                cancelText: this.props.cancelText,
                closeOnSelect: true
            }

            return [
                <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>,
                <TimePicker id={field.name} options={options} onChange={function(e) {   
                    var val = this.get('select');
                    comp.onTextFieldChange({name: comp.props.name},  {target: {value: val}});
                }} />
            ]
        }

        if (field.type == 'switch') {
            var on = 'On';
            var off = 'Off';

            if (field.placeholder && field.placeholder.length === 2) {
                on = field.placeholder[0];
                off = field.placeholder[1];
            }

            var value = false;
            if (field.value) {
                value = String(field.value).toLowerCase() === "true";
            }

            return <Switch id={field.name} name={field.name} onChange={e => this.onCheckboxChanged(field, e) } checked={value} offLabel={off} onLabel={on} />
        }

        if (field.type == 'select') {
            var options = null;
            if (field.validOptions != null) {
                options = field.validOptions.map(function(option, i) {
                    return <option value={option}>{option}</option>
                });
            }
            
            return <Select label={field.placeholder ? field.placeholder[0] : field.name} onChange={e => this.onSelectChanged(field, e) } value={field.value}>
                {options}
            </Select>
        }

        if (field.type == 'radioButtons') {

            var self = this;

            if (!field.validOptions) {
                return <div>-Values is required for radio buttons.</div>
            }

            var options = field.validOptions.map(function(option, idx) {

                return <label
                    htmlFor={`${this.props.inputId}${field.name}${idx}`}
                    key={`${this.props.inputId}${field.name}${idx}`}
                >
                    <input 
                        type="radio" 
                        name={`${this.props.inputId}${field.name}`} 
                        id={`${this.props.inputId}${field.name}${idx}`} 
                        disabled={field.disabled} 
                        onChange={e => self.onRadioChanged(field, e)} 
                        value={option} />
                    <span>{field.placeholder && field.placeholder[idx] ? field.placeholder[idx] : option}</span>
                </label>
            }.bind(this));

            return options;
        }

        if (field.type == 'file' || field.type == 'binaryFile') {
            var self = this;
            
            return (
                <div className="file-field input-field">
                    <div className="btn">
                        <span>{field.placeholder ? field.placeholder[0] : field.name}</span>
                        <input type="file" onChange={e => self.onFileChanged(field, e) } />
                    </div>
                    <div className="file-path-wrapper">
                        <input className="file-path validate" type="text" value={this.state.file} />
                    </div>
                </div>
            )
        }

    }
}
