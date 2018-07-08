import React from 'react';
import {Input as RInput, Row, Col, Preloader} from 'react-materialize';
import {fetchPost} from './services/fetch-service.jsx';
import renderComponent from './services/render-service.jsx';
import UdLink from './ud-link.jsx';
import UdInputField from './ud-input-field.jsx';

export default class Input extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            fields: props.fields,
            newContent: [],
            loading: false
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

    onSubmit() {

        this.setState({
            loading: true
        })
        
        fetchPost(`/component/input/${this.props.id}`, this.state.fields, res => {
                if (res.error) {
                    Materialize.toast(res.error.message, 2000);
                    return;
                }

                res.map(function(x) {
                    if (x.type === "toast") {
                        Materialize.toast(x.text, x.duration);

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
                        this.setState({
                            newContent: x.components
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
                return renderComponent(content);
            });
        }

        var fields = this.state.fields.map(x => {
            return <UdInputField key={x.name} {...x} fontColor={this.props.fontColor} onValueChanged={this.onValueChanged.bind(this)}/>
        });

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <UdLink {...x} key={x.url} />
            });
            actions = <div className="card-action">
                {links}
            </div>
        }

        return <div className="card ud-input" key={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}}>
                    <div className="card-content" >
                        <span className="card-title">{this.props.title}</span>
                        {fields}

                        <Row>
                            <Col s={12} className="right-align">
                                <a href="#!" className="btn" onClick={this.onSubmit.bind(this)}>{this.props.submitText}</a>
                            </Col>
                        </Row>
                    </div>
                    {actions}
                </div>
    }
}