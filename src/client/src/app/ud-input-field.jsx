import React from 'react';
import {Input as RInput, Row, Col, Preloader} from 'react-materialize';
import {DebounceInput} from 'react-debounce-input';
import { fetchPost } from './services/fetch-service';

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
        var fileContent = "";
        var reader = new FileReader();
        
        var _this = this;
        reader.onload = function (e) {
            fileContent = reader.result;
            _this.props.onValueChanged(field.name, fileContent);
        }
        reader.readAsText(file.files[0]);

        var file = e.target.files[0].name;
        this.setState({ file: file });
        
        
    }

    onValidateField(field, e) {
        if (!this.props.validate) return;

        if (this.props.required && (!e.target.value || e.target.value === "")) {
            this.props.onValidateComplete(field.name, `${field.name} is required.`);
            return;
        }

        this.props.onValidating(field.name);

        fetchPost(`/api/internal/component/input/validate/${field.validationEndpoint}/${field.name}`, e.target.value, function(result) {
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

    setupDatePicker() {
        var comp = this;

        $(this.datetime).pickadate({
            selectYears: 100,
            clearText: this.props.clearText,
            okText: this.props.okText,
            cancelText: this.props.cancelText,
            closeOnSelect: true,
            onSet: function(e) {   
                // you can use any of the pickadate options here
                var val = this.get('select', 'dd-mm-yyyy');
                comp.onTextFieldChange({name: comp.props.name},  {target: {value: val}});
                // auto close on select
                //this.close();
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

        if (this.props.type === 'select') {
            $('.select-wrapper').parent().removeClass("col");
        }
    }

    updateTextField() {
        if (this.textField != null) {
            let $this = this.textField;
            if (
              element.value.length > 0 ||
              $(element).is(':focus') ||
              element.autofocus ||
              $this.attr('placeholder') !== null
            ) {
              $this.siblings('label').addClass('active');
            } else if (element.validity) {
              $this.siblings('label').toggleClass('active', element.validity.badInput === true);
            } else {
              $this.siblings('label').removeClass('active');
            }
        }
    }

    componentDidUpdate() {
        this.updateTextField();

        if (this.props.type === 'date') {
            this.setupDatePicker();
        } 

        if (this.props.type === 'time') {
            this.setupTimePicker();
        } 

        $('.tooltipped').tooltip();
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
            var type = field.type == 'textbox' ? 'text' : 'password';

            var validationIcon = null;
            if (this.props.validating) {
                validationIcon = <i className='fa fa-circle-o-notch fa-spin fa-fw tooltipped prefix' data-tooltip="Validating..."></i>
            }
            else if (this.props.validationError != null) {
                validationIcon = <i className='fa fa-times-circle tooltipped red-text prefix' data-tooltip={this.props.validationError}></i>
            }

            var textfield = null;
            if (this.props.debounceTimeout == null) {

                textfield = <input id={field.name} name={field.name} type={type} onChange={e => this.onTextFieldChange(field, e) } value={field.value} onBlur={e => this.onValidateField(field, e)} onKeyDown={this.onKeyDown.bind(this)} ref={ref => this.textField}/>
            } else {
                textfield = <DebounceInput id={field.name} name={field.name} onChange={e => this.onTextFieldChange(field, e) } value={field.value} debounceTimeout={this.props.debounceTimeout}  onKeyDown={this.onKeyDown.bind(this)}/>
            }

            return <div className="input-field">
                        {validationIcon}
                        {textfield}
                        <label id={field.name + 'label'} htmlFor={field.name} style={{color: this.props.fontColor}}>{field.placeholder ? field.placeholder[0] : field.name}</label>
                    </div>
        }

        if (field.type === 'textarea') {
            return <div className="input-field">
                        <textarea className="materialize-textarea" id={field.name} name={field.name} type="textarea" onChange={e => this.onTextFieldChange(field, e) } value={field.value}  onKeyDown={this.onKeyDown.bind(this)}/>
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
                <input type="text" className="datepicker" id={field.name} onChange={e => this.onTextFieldChange(field, e) } value={field.value} ref={datetime => this.datetime = datetime}/>
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

        if (field.type == 'file') {
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