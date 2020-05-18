import React from 'react';
import {Card, Row, Col} from 'react-materialize';

export default class ErrorCard extends React.Component {
    render() {

        var icon = UniversalDashboard.renderComponent({type: 'icon', icon:'ExclamationTriangle', color: 'red'})

        return <Card title={this.props.title} id={this.props.id}>
                    <Row>
                        <Col s={12} className="black-text">
                            <h4>{icon} {this.props.message}</h4>
                            <h5>{this.props.location}</h5>
                        </Col>
                    </Row>
                </Card>
    }
}