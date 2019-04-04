import React from 'react';
import {Card, Row, Col} from 'react-materialize';
import UdIcon from './ud-icon.jsx';

export default class ErrorCard extends React.Component {
    render() {
        return <Card title={this.props.title} id={this.props.id}>
                    <Row>
                        <Col s={12} className="black-text">
                            <h4><UdIcon icon="exclamation-triangle" style={{color: 'red'}} /> {this.props.message}</h4>
                            <h5>{this.props.location}</h5>
                        </Col>
                    </Row>
                </Card>
    }
}