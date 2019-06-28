import React,{Suspense} from 'react';
import {Input as RInput, Row, Col, Preloader} from 'react-materialize';
import UdInputField from './ud-input-field.jsx';
import M from 'materialize-css';

const UdLinkComponent = React.lazy(() => import('./ud-link.jsx' /* webpackChunkName: "ud-link" */))

export default class Input extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            fields: props.fields,
            newContent: [],
            loading: false,
            canSubmit: !props.validate
        }
    }

    onValueChanged(fieldName, value) {
        var fields = this.state.fields.map(function(x) {
            if (x.name === fieldName) {
                x.value = value;
            }

            return x;
        });

        this.setState({
            fields: fields
        });
    }

    onValidating(fieldName) {
        var fields = this.state.fields.map(function(x) {
            if (x.name === fieldName) {
                x.validating = true;
            }

            return x;
        }.bind(this));

        this.setState({
            fields: fields
        });
    }
    
    onValidateComplete(fieldName, errorMessage) {
        var valid = true;

        var fields = this.state.fields.map(function(x) {
            if (x.name === fieldName) {
                x.validating = false;
                x.validationError = errorMessage;
            }

            if (x.validationError) {
                valid = false;
            }

            return x;
        }.bind(this));

        this.setState({
            fields: fields,
            canSubmit: valid
        });
    }

    onSubmit(e) {
        e.preventDefault();

        if (!this.state.canSubmit) return;

        this.setState({
            loading: true
        })
        
        UniversalDashboard.post(`/api/internal/component/input/${this.props.id}`, this.state.fields, res => {
                if (res.error) {

                    UniversalDashboard.toaster.error({message: res.error.message})

                    this.setState({
                        loading: false
                    })
    
                    return;
                }

                res.map(function(x) {
                    if (x.type === "toast") {
                        M.toast({html: x.text, displayLength: x.duration});

                        if (x.clearInput) {
                            var fields = this.state.fields.map(function(x) {
                                if (x.type == "checkbox") {
                                    x.value = false;
                                }

                                if (x.type == "textbox") {
                                    x.value = '';
                                }

                                if (x.type == "select") {
                                    x.value = '';
                                }

                                if (x.type == "password") {
                                    x.value = '';
                                }

                                if (x.type == "textarea") {
                                    x.value = '';
                                }

                                return x;
                            })

                            this.setState({
                                fields: fields
                            })
                        }
                    }
    
                    if (x.type === "redirect") {
                        if (x.route.toLowerCase().startsWith("http") || x.route.toLowerCase().startsWith("http")) {
                            window.location.href = x.route;
                        }

                        this.props.history.push(x.route)
                    }

                    if (x.type === "content") {

                        var components = x.components;
                        if (!Array.isArray(components)) {
                            components = [components];
                        }

                        this.setState({
                            newContent: components
                        })
                    }

                }.bind(this))

                this.setState({
                    loading: false
                })

            });
    }

    render() {
        if (this.state.loading) {
            return <div className="card ud-input" key={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}}>
                        <div className="card-content" >    
                            <span className="card-title">{this.props.title}</span>
                            <div className="center-align">
                                <Preloader size='big'/>
                            </div>
                        </div>
                    </div>
        }

        if (this.state.newContent.length > 0) {
            return this.state.newContent.map(function(content) {
                return UniversalDashboard.renderComponent(content);
            });
        }

        var fields = this.state.fields.map(x => {
            return <UdInputField 
                        validate={this.props.validate} 
                        key={x.name} {...x} 
                        fontColor={this.props.fontColor} 
                        onValueChanged={this.onValueChanged.bind(this)} 
                        onValidating={this.onValidating.bind(this)} 
                        onValidateComplete={this.onValidateComplete.bind(this)} 
                        onEnter={this.onSubmit.bind(this)}
                        inputId={this.props.id}
                        />
        });

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <Suspense fallback={<div>Loading...</div>}>
                    <UdLinkComponent {...x} key={x.url} />
                </Suspense>
            });
            actions = <div className="card-action">
                {links}
            </div>
        }

        var submit = <a href="#!"id={`btn${this.props.id}`} className="btn" onClick={this.onSubmit.bind(this)}>{this.props.submitText}</a>;
        if (!this.state.canSubmit) {
            submit = <a href="#!"id={`btn${this.props.id}`} className="btn disabled">{this.props.submitText}</a>;
        }

        return <div className="card ud-input" key={this.props.id} id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}}>
                    <div className="card-content" >
                        <span className="card-title">{this.props.title}</span>
                        {fields}

                        <Row>
                            <Col s={12} className="right-align">
                                {submit}
                            </Col>
                        </Row>
                    </div>
                    {actions}
                </div>
    }
}